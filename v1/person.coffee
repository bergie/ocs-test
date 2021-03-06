exports.addTests = (suite) ->
    suite.path "/person"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.checkOCS "Person", "/data", "person", true

    suite.checkOCS "Self", "/self", "person", true

    suite.checkOCS "Balance", "/balance", "person", true

    suite.unpath()
