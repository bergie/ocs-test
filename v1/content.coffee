assert = require "assert"
xml2js = require "xml2js"

parser = new xml2js.Parser()

exports.addTests = (suite) ->

    suite.path "/content"

    # Distributions
    suite.discuss("Getting list of distributions")
        .path("/distributions")
        .get()
        .expect(200)
        .expect "Should contain a list", (error, response, body) ->
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                assert.equal result.meta.statuscode, 100
                assert.equal result.data.distribution.length, result.meta.totalitems

                if result.data.distribution.length > 0
                    distro = result.data.distribution[0]
                    assert.ok distro.id, "Distributions have to have an ID"
                    assert.ok distro.name, "Distributions need to be named"
            parser.parseString body
        .undiscuss()
        .unpath()

    suite.unpath()
