exports.addTests = (suite) ->
    suite.path "/message"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.checkOCS "Folders", "", "folder", true

    suite.unpath()
