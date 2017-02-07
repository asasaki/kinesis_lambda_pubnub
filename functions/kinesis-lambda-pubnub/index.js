var PubNub = require('pubnub');

var pubnub = new PubNub({
    publish_key   : process.env.PUBNUB_PUBLISH_KEY,
    subscribe_key : process.env.PUBNUB_SUBSCRIBE_KEY
});

exports.handle = function(event) {
    var channel = process.env.PUBNUB_CHANNEL;
    event.Records.forEach(function(record) {
        var payload = new Buffer(record.kinesis.data, 'base64').toString('ascii');
        console.log("message received: ", payload);
        pubnub.publish(
            {
                channel   : channel,
                message   : payload
            },
            function(status, response){
                if (status.error) {
                    console.log(status);
                } else {
                    console.log("message Published w/ timetoken", response.timetoken);
                }
            }
        );
    });
};
