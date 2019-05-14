var http = require('http');
var faker = require('faker')
const TService = require("./telemetryEventService")
var traceEvents = require("./tracerEvents")
var dispatcher = require('./kafkaDispatcher')
var TRACE_LIMIT_SIZE = 30
var isPushed = false;
var TOTAL_EVENTS_COUNT = 0;
var SYNC_EVENTS = false;
http.createServer(function(req, res) {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
}).listen(8080);

const BATCH_SIZE = 20
const EID_LIST = ["IMPRESSION", "SEARCH", "LOG"];
const EVENT_SIZE_SPLIT = {
    "IMPRESSION": 10,
    "SEARCH": 6,
    "LOG": 4
}
const EVENTS_GENERATE_INTERVAL_TIME = 100 // 15 sec
var events = []
var syncEvents = () => {
    if (events.length >= BATCH_SIZE) {
        var http = require("http");
        var options = {
            "method": "POST",
            "host": "host",
            "port": "8000",
            "path": "/data/v1/telemetry",
            "headers": {
                "Cache-Control": "no-cache",
                "Content-Type": "application/json",
                "Authorization": process.env._aut_key
            }
        };

        var req = http.request(options, function(res) {
            var chunks = [];
            res.on("data", function(chunk) {
                chunks.push(chunk);
            });
            res.on("end", function() {
                var body = Buffer.concat(chunks);
                events.splice(0, BATCH_SIZE)
                TOTAL_EVENTS_COUNT = TOTAL_EVENTS_COUNT + BATCH_SIZE
                console.log(TOTAL_EVENTS_COUNT + " Events are synced", body.toString());
            });
        });
        targetEvents = getTraceEvents()
        isPushed = true
        var data = JSON.stringify({
            id: 'loadtest.telemetry',
            ver: '3.0',
            ets: Date.now(),
            events: targetEvents.splice(0, BATCH_SIZE)
        })
        req.write(data);
        req.end();
    }
}

function dispatch(cb) {
    var target = []
    var targetEvents = Object.assign(target, events);
    if (events.length >= BATCH_SIZE) {
        if ((TOTAL_EVENTS_COUNT >= TRACE_LIMIT_SIZE) && !isPushed) {
            targetEvents = getTraceEvents()
            isPushed = true
            console.log("Tracer events are pushed..")
        }
        dispatcher.dispatch(targetEvents.splice(0, BATCH_SIZE),
            function(err, res) {
                if (err) {
                    console.log('error', err);
                    cb(null, { id: 'loadtest.api.telemetry', params: { err: err } });
                } else {
                    TOTAL_EVENTS_COUNT = TOTAL_EVENTS_COUNT + BATCH_SIZE
                    cb(res, { id: 'loadtest.api.telemetry' });
                }
            })
    }
}

function getTraceEvents() {
    updatedTracerEvents = []
    traceEvents.forEach(function(e) {
        e.mid = "LOAD_TEST_" + process.env.machine_id + "_" + faker.random.uuid() + "_TRACE"
        e.ets = new Date().getTime()
        e.did = faker.random.uuid()
        updatedTracerEvents.push(JSON.parse(JSON.stringify(e)))
    })
    return updatedTracerEvents;
}

function generate(eid, eventsSize) {
    for (let index = 1; index <= eventsSize; index++) {
        var eventData = TService.generateEvents(eid)
        events.push(JSON.parse(JSON.stringify(eventData)))
        SYNC_EVENTS ? syncEvents() : dispatch(function(res, err) { if (res) { console.log(res) } else { console.log("Failed to push into kafka") } })
    }
}



setInterval(() => {
    generate(EID_LIST[0], EVENT_SIZE_SPLIT[EID_LIST[0]])
    generate(EID_LIST[1], EVENT_SIZE_SPLIT[EID_LIST[1]])
    generate(EID_LIST[2], EVENT_SIZE_SPLIT[EID_LIST[2]])
}, EVENTS_GENERATE_INTERVAL_TIME)