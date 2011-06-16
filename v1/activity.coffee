exports.addTests = (suite) ->
    suite.path "/activity"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.checkOCS "Activities", "", "activity", true

    suite.unpath()
