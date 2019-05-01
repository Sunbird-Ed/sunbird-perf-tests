var kafka = require('kafka-node'),
    Producer = kafka.Producer,
    client = new kafka.KafkaClient({ kafkaHost: 'localhost:9092' }),
    forEach = require('async-foreach').forEach
producer = new Producer(client);


client.on('ready', function() {
    console.log('kafka is ready ready');
})

client.on('error', function(err) {
    console.log('kafka is not ready : ' + err);
})


var KafkaDispatcher = {
    dispatch: function(telemetryEvent, cb) {
        payloads = [{
            topic: 'loadtest.telemetry.ingest'
        }];
        payloads[0].messages = JSON.stringify(telemetryEvent)
        producer.send(payloads, function(err, res) {
            if (res) {
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