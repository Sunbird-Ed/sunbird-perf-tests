var kafka = require('kafka-node'),
    Producer = kafka.Producer,
    client = new kafka.KafkaClient({ kafkaHost: '28.0.3.25:9092' }),
    producer = new Producer(client);

var KafkaDispatcher = {
    dispatch: function(telemetryEvent, cb) {
        payloads = [{
            topic: 'loadtest.telemetry.ingest'
        }];
        payloads[0].messages = JSON.stringify(telemetryEvent)
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