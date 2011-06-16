assert = require "assert"
xml2js = require "xml2js"

exports.addTests = (suite) ->

    suite.path "/content"

    suite.discuss("List of categories")
        .path("/categories")
        .get()
        .expect(200)
        .expect "Should contain a list", (error, response, body) ->
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                assert.equal result.meta.statuscode, 100
                assert.equal result.data.category.length, result.meta.totalitems

                if result.data.category.length > 0
                    category = result.data.category[0]
                    assert.ok category.id, "Categories have IDs"
                    assert.ok category.name, "Categories have names"
            parser.parseString body
        .undiscuss()
        .unpath()

    suite.discuss("List of licenses")
        .path("/licenses")
        .get()
        .expect(200)
        .undiscuss()
        .unpath()

    suite.discuss("List of distributions")
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
                    assert.ok distro.id, "Distributions have IDs"
                    assert.ok distro.name, "Distributions have names"
            parser.parseString body
        .undiscuss()
        .unpath()

    suite.discuss("List of dependencies")
        .path("/dependencies")
        .get()
        .expect(200)
        .undiscuss()
        .unpath()

    suite.unpath()
