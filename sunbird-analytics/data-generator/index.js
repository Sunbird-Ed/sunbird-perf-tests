// Read the process parameter
let data = require('./data');
//var kafka = require('kafka-node')
//var client = new kafka.KafkaClient({ kafkaHost: '28.0.3.25:9092' })
let faker = require('faker');
var async = require("async");
let eventsToBeGenerated = process.argv[2];
console.log("eventsToBeGenerated" + eventsToBeGenerated)
let events = [];
let batchSize = 200;
let ratio = { impression: 100, search: 60, log: 40 };
let loops = eventsToBeGenerated / batchSize;
var kafkaDispatcher = require('./kafkaDispatcher')
require('events').EventEmitter.defaultMaxListeners = 10000


function getEvent(type) {
    let event = data[type];
    if (type === "SEARCH") {
        event.edata.filters.dialcodes = faker.random.arrayElement(data.dialCodes)
    }
    event.mid = "LOAD_TEST_" + process.env.machine_id + "_" + faker.random.uuid()
    event.context.did = faker.random.arrayElement(data.dids);
    event.context.channel = faker.random.arrayElement(data.channelIds);
    event.object.id = faker.random.arrayElement(data.contentIds);
    return event;
}

function generateBatch(cb) {
    for (let i = 0; i < ratio.log; i++) {
        events.push(JSON.parse(JSON.stringify(getEvent('LOG'))));
    }
    for (let i = 0; i < ratio.impression; i++) {
        events.push(JSON.parse(JSON.stringify(getEvent('IMPRESSION'))));
    }
    for (let i = 0; i < ratio.search; i++) {
        events.push(JSON.parse(JSON.stringify(getEvent('SEARCH'))));
    }
    if (events.length >= batchSize) {
        dispatch(events.splice(0, batchSize), function(err, res) {
            if (err) {
                console.error("error occur" + err)
                cb(err, undefined)
            } else {
                if (cb) cb(undefined, res)
            }
        })
    } else {
        if (cb) cb()
    }
}

function dispatch(message, cb) {
    kafkaDispatcher.dispatch(message,
        function(err, res) {
            if (err) {
                console.log('error', err);
                cb(err, undefined)
            } else {
                cb(undefined, res)
            }
        })
}

function generateData() {
    for (let i = 1; i <= loops; i++) {
        generateBatch(function(err, res) {
            console.log("callback")
        });
    }

    var tracerEvents = getTraceEvents()
    console.log("Dispatching trace events...")
    dispatch(tracerEvents, function(err, res) {
        if (!err) {
            console.log("Tracer Events are pushed")
        } else {
            console.error("Error occur due to" + err)
        }
    })
    console.log("Process is done")
}

function getTraceEvents() {
    var traceEvents = require("./tracerEvents")
    updatedTracerEvents = []
    traceEvents.forEach(function(e) {
        e.mid = "LOAD_TEST_" + process.env.machine_id + "_" + faker.random.uuid() + "_TRACE"
        e.ets = new Date().getTime()
        e.did = faker.random.uuid()
        updatedTracerEvents.push(JSON.parse(JSON.stringify(e)))
    })
    return updatedTracerEvents;
}

// setTimeout(function() {
//     generateData()
// }, 2000)

(async function loop() {
    for (let i = 1; i <= loops; i++) {
        await new Promise(resolve => generateBatch(function() {
            console.log("Number of iteration:" + i);
            resolve()
        }));
    }
    var tracerEvents = getTraceEvents()
    dispatch(tracerEvents, function(err, res) {
        if (!err) {
            console.log(tracerEvents.length + " Tracer Events are pushed")
            console.log("Process is done")
        } else {
            console.error("Error occur due to" + err)
        }
    })
})();