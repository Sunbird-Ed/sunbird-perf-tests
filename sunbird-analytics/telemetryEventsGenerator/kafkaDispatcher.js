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
        itemsProcessed = 0;
        payloads = [{
            topic: 'loadtest.telemetry.ingest'
        }];
        forEach(telemetryEvent.events, function(item, index, arr) {
            payloads[0].messages = JSON.stringify(item)
            console.log("Before Events are ", payloads[0].messages)
            producer.send(payloads, function(err, data) {
                console.log("Events are pushed");
                if (!err) itemsProcessed++
                    if (itemsProcessed === arr.length) {
                        if (cb) cb(err, data)
                    }
            });

        });

        producer.on('error', function(err, data) {
            console.log('error: ' + err);
            if (cb) cb(err, data)
        });
    }
}