exports.addTests = (suite) ->
    suite.path "/event"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.checkOCS "Events", "/data", "event", true

    suite.unpath()
