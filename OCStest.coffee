assert = require "assert"
xml2js = require "xml2js"

# Base test for OCS
class OCStest
    name: null
    path: null
    resource: null

    constructor: (@name, @path, @resource) ->

    # Method for replacing the standard field verifier method with a
    # custom callback
    verify: (callback) ->
        @verifyFields = callback 

    verifyFields: (item) ->
        assert.ok item.id, "#{@name} resources have IDs"
        assert.ok item.name, "#{@name} resources have names"

    verifyData: (result) =>
        assert.equal result.meta.statuscode, 100, "Got statuscode #{result.meta.statuscode} instead of expected 100"
        if result.data[@resource]?.length > 0
            @verifyFields result.data[@resource][0]

    register: (suite) ->
        suite.discuss(@name)
            .path(@path)
            .get()
            .expect(200)
            .expect "result needs to follow specification", (error, response, body) =>
                unless response.statusCode is 200
                    assert.fail "Nope"
                    return
                parser = new xml2js.Parser()
                parser.on "end", @verifyData
                parser.parseString body
            .undiscuss()
            .unpath()

exports.OCStest = OCStest
