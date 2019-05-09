// Read the process parameter
let data = require('./data');
let faker = require('faker');
var async = require("async");
let eventsToBeGenerated = process.argv[2];
let trace = process.argv[3];
console.log("eventsToBeGenerated" + eventsToBeGenerated)
let events = [];
let batchSize = 200;
let impression = process.argv[5];
let search = process.argv[6];
let log = process.argv[7];
let ratio = { impression: impression, search: search, log: log };
let loops = eventsToBeGenerated / batchSize;
var kafkaDispatcher = require('./kafkaDispatcher')
require('events').EventEmitter.defaultMaxListeners = 10000
let topic = process.argv[4];
let key = "ingest"


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
        let isBatch = topic.includes(key) ? true : false
        dispatch(events.splice(0, batchSize), isBatch,
            function(err, res) {
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

function dispatch(message, batch, cb) {
    if (batch) {
        kafkaDispatcher.dispatchBatch(message,
            function(err, res) {
                if (err) {
                    console.log('error', err);
                    cb(err, undefined)
                } else {
                    cb(undefined, res)
                }
            })
    } else {
        (async function loop() {
            for (let i = 0; i < message.length; i++) {
                await new Promise(resolve => kafkaDispatcher.dispatch(message[i], function() {
                    resolve(cb())
                }));
            }
        })();
    }
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


(async function loop() {
    console.log("Generating IMPRESSION:" + impression + " LOG: " + log + " SEARCH: " + search)
    for (let i = 1; i <= loops; i++) {
        await new Promise(resolve => generateBatch(function() {
            resolve()
        }));
    }
    if (trace === "true") {
        let isBatch = topic.includes(key) ? true : false
        var tracerEvents = getTraceEvents()
        dispatch(tracerEvents, isBatch, function(err, res) {
            if (!err) {
                console.log("Event pushed")
            } else {
                console.error("Error occur due to" + err)
            }
        })
    }
})();