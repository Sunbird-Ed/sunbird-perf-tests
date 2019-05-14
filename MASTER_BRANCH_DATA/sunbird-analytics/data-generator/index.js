// Read the process parameter
let data = require('./data');
let faker = require('faker');
let eventsToBeGenerated = process.argv[0];

let batchSize = 200;
let ratio = {impression: 100, search: 50, log: 50};
let loops = eventsToBeGenerated/batchSize;


function getEvent(type) {
    let event = data[type];
    event.mid = faker.random.uuid();
    event.context.did = data.dids[faker.random.number({ min: 1, max: 1000 })];
    event.object.id = data.contentIds[faker.random.number({ min: 1, max: 1000 })];
    return event;
}

function generateBatch() {
    let events = [];
    for (i = 0; i < ratio.impression; i++) {
        events.push(getEvent('IMPRESSION'));
    }
    for (i = 0; i < ratio.search; i++) {
        events.push(getEvent('SEARCH'));
    }
    for (i = 0; i < ratio.log; i++) {
        events.push(getEvent('LOG'));
    }
    kafkaDispatcher.dispatch(events);
}

function generateData() {
    for (i = 0; i < batchSize; i++) {
        generateBatch();
    }
    console.log("events", 0, "batches", 0);
}