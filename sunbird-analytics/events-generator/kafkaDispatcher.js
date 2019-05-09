var kafka = require('kafka-node'),
    Producer = kafka.Producer,
    client = new kafka.KafkaClient({ kafkaHost: '28.0.3.25:9092, 28.0.3.27:9092, 28.0.3.26:9092' }),
    //client = new kafka.KafkaClient({kafkaHost: 'localhost:9092'}),
    producer = new Producer(client)
var count = 0;
var incrementor = 0;
let topic = process.argv[4];
let nof_partition = process.argv[8]
var partitions = [];
console.log("nof_partition" + nof_partition)
client.on('ready', function() {
    console.log('kafka is ready ready');
})

client.on('error', function(err) {
    console.log('kafka is not ready : ' + err);
})

var KafkaDispatcher = {
    dispatchBatch: function(telemetryEvent, cb) {
        var eventObject = { "id": "loadtest.telemetry", "ver": "3.0", "ets": new Date().getTime(), "events": telemetryEvent, "mid": "56c0c430-748b-11e8-ae77-cd19397ca6b0", "syncts": 1529500243955 }
        payloads = [{
            topic: topic,
            partition: getPartitionNumber()
        }];
        payloads[0].messages = JSON.stringify(eventObject)
        console.log("payloads" + telemetryEvent.length)
        producer.send(payloads, function(err, res) {
            if (res) {
                count = count + telemetryEvent.length
                console.log("Total Events pushed: " + count)
                if (cb) cb(undefined, res)
            }
        })
        producer.on('error', function(err, data) {
            console.log('error: ' + err);
            if (err) {
                if (cb) cb(err, undefined)
            }
        });
    },
    dispatch: function(event, cb) {
        payloads = [{
            topic: topic,
            partition: getPartitionNumber(),
        }];
        payloads[0].messages = JSON.stringify(event)
        producer.send(payloads, function(err, res) {
            if (res) {
                count = count + 1
                console.log("Total Events pushed: " + count)
                if (cb) cb(undefined, res)
            }
        })
        producer.on('error', function(err, data) {
            console.log('error: ' + err);
            if (err) {
                if (cb) cb(err, undefined)
            }
        });

    },
    initialize: function() {


    }
}

function getPartitionNumber() {
    partitions = [0, 1, 2, 3, 4, 5, 6, 7]
    var res = undefined
    incrementor++
    if (incrementor <= 8) {
        res = partitions[incrementor - 1]
        if (incrementor === 8) {
            incrementor = 0
        }
        return res
    }

}

module.exports = KafkaDispatcher