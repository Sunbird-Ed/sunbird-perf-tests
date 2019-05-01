module.exports.LOG = {
    "eid": "LOG",
    "ets": 1556563605990,
    "ver": "3.0",
    "mid": "LP.1556563605990.86ce3bc0-232f-459d-9dd3-2961bf1135ce",
    "actor": {
        "id": "org.ekstep.learning.platform",
        "type": "System"
    },
    "context": {
        "channel": "505c7c48ac6dc1edc9b08f21db5a571d",
        "pdata": {
            "id": "prod.ntp.learning.platform",
            "pid": "search-service",
            "ver": "1.0"
        },
        "env": "search",
        "did": "62550758ee02728890a049f0468e08280655f206"
    },
    "edata": {
        "level": "INFO",
        "type": "api_access",
        "message": "",
        "params": [{
                "duration": 10
            },
            {
                "protocol": "HTTP"
            },
            {
                "size": 41796
            },
            {
                "method": "POST"
            },
            {
                "rid": "ekstep.composite-search.search"
            },
            {
                "uip": "11.4.0.22"
            },
            {
                "url": "/v3/search"
            },
            {
                "status": 200
            },

            { "filters": { "contentType": ["TextBook"], "status": ["Live"], "objectType": ["Content"], "compatibilityLevel": { "max": 4, "min": 1 }, "channel": { "ne": ["0124433024890224640", "0124446042259128320", "0124487522476933120", "0125840271570288640", "0124453662635048969"] }, "framework": {}, "mimeType": {}, "resourceType": {} }, "sort_by": { "me_averageRating": "desc" }, "limit": 10, "mode": "soft" }

        ]
    },
    "object": {},
    "flags": {
        "tv_processed": true,
        "dd_processed": true
    },
    "type": "events",
    "syncts": 1556563606772,
    "@timestamp": "2019-04-29T18:46:46.772Z"
};
module.exports.IMPRESSION = {
    "actor": {
        "type": "User",
        "id": "26617c52-7965-4d54-b8a3-863f732abf9c"
    },
    "edata": {
        "type": "view",
        "pageid": "library-page-filter",
        "uri": "library-page-filter"
    },
    "eid": "IMPRESSION",
    "ver": "3.0",
    "ets": 1556667915085,
    "context": {
        "pdata": {
            "ver": "2.1.8",
            "pid": "sunbird.app",
            "id": "prod.diksha.app"
        },
        "channel": "01235953109336064029450",
        "env": "home",
        "did": "2728d40c6d897cd223078dd6f2f5d351937b3350",
        "sid": "80fc2adf-978e-454c-94fc-4e2a512586a8",
        "cdata": []
    },
    "mid": "f39d81fe-514d-41b9-9fcc-c08f92ebcb7c",
    "object": {
        "id": "",
        "type": "",
        "version": ""
    },
    "tags": [],
    "syncts": 1555976723292,
    "@timestamp": "2019-04-22T23:45:23.292Z",
    "flags": {
        "tv_processed": true,
        "dd_processed": true,
        "device_location_retrieved": true,
        "user_location_retrieved": false
    },
    "type": "events",
    "ts": "2019-04-30T23:45:15.085+0000",
    "devicedata": {
        "statecustomcode": "",
        "country": "",
        "city": "",
        "countrycode": "",
        "state": "",
        "statecode": "",
        "districtcustom": "",
        "statecustomname": ""
    },
    "userdata": {
        "district": "",
        "state": ""
    }
};
module.exports.SEARCH = {
    "eid": "SEARCH",
    "ets": 1556709158182,
    "ver": "3.0",
    "mid": "LP.1556709158182.b8cc03f1-6641-4e39-8cb9-f6fb78cfe194",
    "actor": {
        "id": "org.ekstep.learning.platform",
        "type": "System"
    },
    "context": {
        "channel": "in.ekstep",
        "pdata": {
            "id": "staging.sunbird.learning.platform",
            "pid": "search-service",
            "ver": "1.0"
        },
        "env": "search"
    },
    "edata": {
        "size": 235014,
        "query": "",
        "filters": {},
        "sort": {},
        "type": "all",
        "topn": [{
                "identifier": "mh_fm_1_topic_science_usefulandharmfulmicrobes_harmfulmicroorganismsclostridiumandothers"
            },
            {
                "identifier": "mh_fm_1_topic_science_classificationofplants_subkingdomangiosperms"
            },
            {
                "identifier": "do_21254796078943436811896"
            },
            {
                "identifier": "do_21254869206212608012477"
            },
            {
                "identifier": "do_21253024920136089612518"
            }
        ]
    },
    "object": {},
    "flags": {
        "tv_processed": true,
        "dd_processed": true,
        "ldata_retrieved": false
    },
    "type": "events",
    "syncts": 1556709159120,
    "@timestamp": "2019-05-01T11:12:39.120Z",
    "ts": "2019-05-01T11:12:38.182+0000",
    "ldata": {
        "country_code": "",
        "country": "",
        "city": "",
        "state": "",
        "state_code": ""
    }
};

// module.exports.envelop = {
//     "LOG": {},
//     "IMPRESSION": {},
//     "SEARCH": {}
// }


module.exports.dids = [];
module.exports.contentIds = [];