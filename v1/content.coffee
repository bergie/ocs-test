assert = require "assert"
xml2js = require "xml2js"

verifyList = (res, key) ->
    assert.equal res.meta.statuscode, 100, "Statuscode 100 means successful operation"
    if res.meta.totalitems > 0
        assert.equal res.data[key].length, res.meta.totalitems

exports.addTests = (suite) ->
    suite.path "/content"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.discuss("List of categories")
        .path("/categories")
        .get()
        .expect(200)
        .expect "Should contain a list", (error, response, body) ->
            unless response.statusCode is 200
                assert.fail "Nope"
                return
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                verifyList result, "category"

                if result.data.category?.length > 0
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
        .expect "Should contain a list", (error, response, body) ->
            unless response.statusCode is 200
                assert.fail "Nope"
                return
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                verifyList result, "license"
            parser.parseString body
        .undiscuss()
        .unpath()

    suite.discuss("List of distributions")
        .path("/distributions")
        .get()
        .expect(200)
        .expect "Should contain a list", (error, response, body) ->
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                verifyList result, "distribution"

                if result.data.distribution?.length > 0
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
        .expect "Should contain a list", (error, response, body) ->
            unless response.statusCode is 200
                assert.fail "Nope"
                return
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                verifyList result, "dependency"
            parser.parseString body
        .undiscuss()
        .unpath()

    suite.discuss("List of home page types")
        .path("/homepagetypes")
        .get()
        .expect(200)
        .expect "Should contain a list", (error, response, body) ->
            unless response.statusCode is 200
                assert.fail "Nope"
                return
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                verifyList result, "homepagetypes"
            parser.parseString body
        .undiscuss()
        .unpath()

    suite.discuss("List of all content items")
        .path("/data")
        .get()
        .expect(200)
        .expect "Should contain a list", (error, response, body) ->
            unless response.statusCode is 200
                assert.fail "Nope"
                return
            parser = new xml2js.Parser()
            parser.on "end", (result) ->
                verifyList result, "content"
            parser.parseString body
        .undiscuss()
        .unpath()

    suite.unpath()
