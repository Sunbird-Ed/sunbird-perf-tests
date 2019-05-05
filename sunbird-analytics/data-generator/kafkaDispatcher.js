var kafka = require('kafka-node'),
    Producer = kafka.Producer,
    client = new kafka.KafkaClient({ kafkaHost: '28.0.3.25:9092' }),
    producer = new Producer(client);
var count = 0;
var incrementor = 0;

client.on('ready', function() {
    console.log('kafka is ready ready');

})

client.on('error', function(err) {
    console.log('kafka is not ready : ' + err);
})
var KafkaDispatcher = {
    dispatch: function(telemetryEvent, cb) {
        var eventObject = { "id": "loadtest.telemetry", "ver": "3.0", "ets": new Date().getTime(), "events": telemetryEvent, "mid": "56c0c430-748b-11e8-ae77-cd19397ca6b0", "syncts": 1529500243955 }
        payloads = [{
            topic: 'loadtest.telemetry.ingest',
            partition: getPartitionNumber()
        }];
        payloads[0].messages = JSON.stringify(eventObject)
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
    }
}

function getPartitionNumber() {
    var res = undefined
    var partition = [0, 1, 2, 3]
    incrementor++
    if (incrementor <= 4) {
        res = partition[incrementor - 1]
        if (incrementor === 4) {
            incrementor = 0
        }
        return res
    }

}

module.exports = KafkaDispatcher