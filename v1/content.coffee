assert = require "assert"

exports.addTests = (suite) ->
    suite.path "/content"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.checkOCS "Category", "/categories", "category"
    suite.checkOCS "License", "/licenses", "license"
    suite.checkOCS "Dependency", "/dependencies", "dependtypes"
    suite.checkOCS "Homepage type", "/homepagetypes", "homepagetypes"

    checkDate = (dateString) ->
        dateObj = new Date dateString
        assert.ok dateObj.getTime(), "Date properties need to be proper ISO"

    checkContent = (item) ->
        assert.ok item.id, "Content items have IDs"
        assert.ok item.name, "Content items have names"
        assert.ok item.version, "Content items have version numbers"
        assert.ok item.changed, "Content items have a changed date"
        checkDate item.changed
        assert.ok item.created, "Content items have a creation date"
        checkDate item.created
        assert.ok item.typeid, "Content items have type IDs"
        assert.ok item.typename, "Content items have type names"
        assert.ok item.personid, "Content items have person IDs"
        assert.ok item.profilepage, "Content items have profile page URLs"
        assert.ok item.downloads, "Content items have a downloads count"
        assert.ok item.score, "Content items have score"
        assert.ok item.comments, "Content items have comments count"
        assert.ok item.preview1, "Content items have previews"

    suite.checkOCS("Content item", "/data", "content")
        .verify checkContent

    # Some methods to test that require real information about contents of 
    # service (category IDs, content IDs etc)
    # TODO: /data?category=1
    # TODO: /data?category=1x2
    # TODO: /data/1
    # TODO: /download/1/1
    # TODO: /recommendations/1

    suite.unpath()
