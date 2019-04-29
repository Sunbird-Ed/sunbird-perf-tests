var faker = require('faker')

const EID_LIST = ["IMPRESSION", "SEARCH", "LOG"];
const ACTOR_TYPE = ["User", "System"]
const CONTEXT_ENV = ["contentplayer", "home", "workspace", "explore", "public", "library", "course", "user"]
const PDATA_PID = ["sunbird-portal", "sunbird-portal.contentplayer", "sunbird.app", "sunbird-portal.contenteditor", "sunbird-portal.collectioneditor", "sunbird-portal.collectioneditor.contentplayer"]
const PDATA_ID = ["sunbird-portal", "sunbird.app"]
const OBJECT_TYPE = ["Content", "Community", "User"]
const OBJECT_IDENTIFIER = [
    "do_21271780182595993616932",
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
]
var presentDate = new Date();
const ETS_GENERATION_DATE_RANGE = { from: "2019-04-15", to: presentDate.getFullYear() + '-' + (presentDate.getMonth() + 1) + '-' + presentDate.getDate() }

var TelemetryService = {
    generateEvents(eid) {
        var eData = this.getEventData(eid)
        return this.updateEventEnvelop(eData, eid)
    },

    getEventData(eid) {
        const eventData = require('./eventData')
        return eventData[eid.toLowerCase()]
    },
    updateEventEnvelop(eData, eid) {
        const eventEnvelop = require('./envelop.js')
        eventEnvelop.edata = eData
        eventEnvelop.eid = eid
        eventEnvelop.ets = faker.date.between(ETS_GENERATION_DATE_RANGE.from, ETS_GENERATION_DATE_RANGE.to).getTime()
        eventEnvelop.mid = "LOAD_TEST_" + faker.random.uuid()
            // update actor object
        eventEnvelop.actor.type = faker.random.arrayElement(ACTOR_TYPE)
        eventEnvelop.actor.id = faker.random.uuid()
            // Update context object 
        eventEnvelop.context.channel = faker.random.uuid()
        eventEnvelop.context.did = faker.random.uuid()
        eventEnvelop.context.env = faker.random.arrayElement(CONTEXT_ENV)
        eventEnvelop.context.sid = faker.random.uuid()
            //update context pdata object 
        eventEnvelop.context.pdata.pid = faker.random.arrayElement(PDATA_PID)
        eventEnvelop.context.pdata.id = faker.random.arrayElement(PDATA_ID)
        eventEnvelop.context.pdata.ver = faker.random.number({ min: 1, max: 10 }).toString()
        eventEnvelop.context.rollup.l1 = faker.random.arrayElement(OBJECT_IDENTIFIER)
        eventEnvelop.context.rollup.l2 = "do_" + faker.random.uuid()
        eventEnvelop.context.rollup.l3 = "do_" + faker.random.uuid()
        eventEnvelop.context.rollup.l4 = "do_" + faker.random.uuid()



        // update object data
        eventEnvelop.object.id = faker.random.arrayElement(OBJECT_IDENTIFIER)
        eventEnvelop.object.ver = faker.random.number({ min: 1, max: 4 }).toString()
        eventEnvelop.object.type = faker.random.arrayElement(OBJECT_TYPE)
        eventEnvelop.object.rollup.l1 = faker.random.arrayElement(OBJECT_IDENTIFIER)
        eventEnvelop.object.rollup.l2 = faker.random.arrayElement(OBJECT_IDENTIFIER)
        eventEnvelop.object.rollup.l3 = faker.random.arrayElement(OBJECT_IDENTIFIER)
        eventEnvelop.object.rollup.l4 = faker.random.arrayElement(OBJECT_IDENTIFIER)

        // update tags
        eventEnvelop.tags = [faker.random.uuid()]
            //console.log("Telemetry Event: " + JSON.stringify(eventEnvelop))
            //console.log("size" + Buffer.byteLength(JSON.stringify(eventEnvelop), 'utf8'))
        return eventEnvelop
    }
}
module.exports = TelemetryService