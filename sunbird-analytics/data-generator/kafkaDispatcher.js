var kafka = require('kafka-node'),
    Producer = kafka.Producer,
    client = new kafka.KafkaClient({ kafkaHost: '28.0.3.25:9092' }),
    producer = new Producer(client);

var KafkaDispatcher = {
    dispatch: function(telemetryEvent, cb) {
        var eventObject = { "id": "loadtest.telemetry", "ver": "3.0", "ets": new Date().getTime(), "events": telemetryEvent, "mid": "56c0c430-748b-11e8-ae77-cd19397ca6b0", "syncts": 1529500243955 }
        payloads = [{
            topic: 'loadtest.telemetry.ingest'
        }];
        payloads[0].messages = JSON.stringify(eventObject)
        console.log("payloads" + payloads)
        producer.send(payloads, function(err, res) {
            if (res) {
                console.log("Success")
                if (cb) cb(err, res)
            }
        })
        producer.on('error', function(err, data) {
            console.log('error: ' + err);
            if (cb) cb(err, data)
        });
    }
}
module.exports = KafkaDispatcher