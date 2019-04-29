var faker = require('faker')
var EventData = {
    "start": {
        "type": faker.random.arrayElement(["app", "session", "editor", "player", "workflow", "assessment"]),
        "dspec": "",
        "uaspec": "",
        "loc": "",
        "mode": faker.random.arrayElement(["play", "edit", "preview"]),
        "duration": (faker.random.number({ min: 1, max: 9 }) * 1000),
        "pageid": ""
    },
    "end": {
        "type": faker.random.arrayElement(["app", "session", "editor", "player", "workflow", "assessment"]),
        "mode": faker.random.arrayElement(["play", "edit", "preview"]),
        "duration": (faker.random.number({ min: 1, max: 200 })),
        "pageid": faker.random.uuid(),
        "summary": []

    },
    "impression": {
        "type": faker.random.arrayElement(["list", "detail", "view", "edit", "workflow", "search"]),
        "subtype": faker.random.arrayElement(["Paginate", "Scroll"]),
        "pageid": faker.random.uuid(),
        "uri": faker.random.arrayElement(["/home", "/resources", "/learn", "/signup", "/workspace/content/create", "/explore"]),
        "duration": (faker.random.number({ min: 1, max: 60 })),
        "visits": [{
            "objid": faker.random.arrayElement(
                ["do_21271780182595993616932",
                    "do_21274813398450176015065",
                    "do_21273327871526502413924",
                    "do_21274109254696140814898",
                    "do_21273610197362278414264",
                    "do_21270182445096140811457",
                    "do_312469507013812224118164",
                    "do_312466405614305280216635",
                    "do_312593229238837248123109",
                    "do_312470914624577536218447",
                    "do_2127270883650600961273"
                ]),
            "objtype": faker.random.arrayElement(["Resource", "Course", "TextBook"]),
            "objver": (faker.random.number({ min: 0, max: 1 })).toString(),
            "section": faker.random.arrayElement(["Popular Books", "My Course", "My Resource"]),
            "index": (faker.random.number({ min: 1, max: 2 })),
        }]
    },
    "interact": {
        "type": "",
        "subtype": "",
        "id": "",
        "pageid": "",
        "target": "",
        "duration": "",
        "plugin": "",
        "extra": {
            "pos": [{}],
            "values": []
        }
    },
    "log": {
        "type": "api_access", // Required. Type of log (system, process, api_access, api_call, job, app_update etc)
        "level": faker.random.arrayElement(["INFO", "FATAL", "WARN", "ERROR", "DEBUG"]), // Required. Level of the log. TRACE, DEBUG, INFO, WARN, ERROR, FATAL
        "message": faker.random.arrayElement(["TelemetryServiceImpl sync@SyncServiceImpl", "UserProfileServiceImpl getUserProfileDetails@UserProfileServiceImpl", "ContentServiceImpl searchSunbirdContent@ContentServiceImpl"]),
        "pageid": faker.random.uuid(),
        "params": [{ "service": "UserProfileServiceImpl" }, { "method": "getUserProfileDetails@UserProfileServiceImpl" }, { "mode": "MDATA" },
            {
                "request": {
                    "logLevel": "2",
                    "request": { "refreshUserProfileDetails": false, "returnRefreshedUserProfileDetails": false, "userId": "8ac9ee6e-e622-422d-969d-b87d64704ad4" }
                }
            }
        ]
    },
    "search": {
        "type": faker.random.arrayElement(["all", "content", "org"]),
        "query": faker.random.word(),
        "filters": {
            "dialcodes": faker.random.arrayElement(["FGGWGM", "71EHR5", "KP9I3J", "ETINEA"]),
            "channel": {
                "ne": ["0124433024890224640", "0124446042259128320", "0124487522476933120", "0125840271570288640"]
            }
        },
        "sort": {},
        "correlationid": "",
        "size": faker.random.number({ min: 10, max: 50 }),
        "topn": [{ "identifier": faker.random.arrayElement(["do_312469516571246592118169", "do_312469516571246592118169", "do_21271780182595993616932", "do_312473754833977344219585"]) }] // Required. top N (configurable) results with their score
    }


}
module.exports = EventData