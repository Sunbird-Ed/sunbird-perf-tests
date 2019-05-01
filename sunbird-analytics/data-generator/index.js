// Read the process parameter
let data = require('./data');
var kafka = require('kafka-node')
var client = new kafka.KafkaClient({ kafkaHost: 'localhost:9092' })
let faker = require('faker');
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
    event.mid = faker.random.uuid();
    event.context.did = data.dids[faker.random.number({ min: 1, max: 1000 })];
    event.object.id = data.contentIds[faker.random.number({ min: 1, max: 1000 })];
    return event;
}

function generateBatch() {

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
        console.log("Events are" + events.length)
        dispatch(events.splice(0, batchSize), function(err, res) {
            if (err) {
                console.error("error occure" + err)
            }
        })
    }
}

function dispatch(message) {
    kafkaDispatcher.dispatch(message,
        function(err, res) {
            if (err) {
                console.log('error', err);
            }
        })
}

function generateData() {
    for (i = 1; i <= loops; i++) {
        generateBatch();
    }
    var tracerEvents = getTraceEvents()
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
client.on('ready', function() {
    console.log('kafka is ready ready');
    generateData()
})

client.on('error', function(err) {
    console.log('kafka is not ready : ' + err);
})