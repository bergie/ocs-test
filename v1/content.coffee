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
    suite.checkOCS "Content item", "/data", "content"

    suite.unpath()
