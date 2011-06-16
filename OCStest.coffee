assert = require "assert"
xml2js = require "xml2js"

# Base test for OCS
class OCStest
    name: null
    path: null
    resource: null
    requireAuth: false

    constructor: (@name, @path, @resource, requireAuth) ->
        @requireAuth = requireAuth ? false

    # Method for replacing the standard field verifier method with a
    # custom callback
    verify: (callback) ->
        @verifyFields = callback 

    verifyFields: (item) ->
        assert.ok item.id, "#{@name} resources have IDs"
        assert.ok item.name, "#{@name} resources have names"

    verifyData: (result) =>
        statuscode = result.meta?.statuscode ? result.statuscode
        assert.equal statuscode, 100, "Got statuscode #{statuscode} instead of expected 100"
        if result.data[@resource]?.length > 0
            @verifyFields result.data[@resource][0]

    fetchAnon: (suite, json) ->
        contentType = "application/xml"
        format = "XML"
        path = @path
        if json
            contentType = "application/json"
            format = "JSON"
            path = "#{@path}?format=json"

        suite.discuss("#{@name} #{format}")
            .path(path)
            .get()
            .expect(200)
            .expect "result needs to be in #{contentType} format", (error, response, body) ->
                assert.equal response.headers["content-type"], contentType
            .expect "result needs to follow specification", (error, response, body) =>
                unless response.statusCode is 200
                    assert.fail "Nope"
                    return

                if json
                    try
                        data = JSON.parse body
                    catch e
                        assert.fail "JSON format should be parseable"
                        return
                    @verifyData data
                    return

                parser = new xml2js.Parser()
                parser.on "end", @verifyData
                parser.parseString body
            .undiscuss()
            .unpath()

    registerAnon: (suite) ->
        @fetchAnon suite, false
        @fetchAnon suite, true

    register: (suite) ->
        unless @requireAuth
            @registerAnon suite
            return

        suite.discuss("#{@name} should require authentication")
            .path(@path)
            .get()
            .expect(401)
            .undiscuss()
            .unpath()

exports.OCStest = OCStest
