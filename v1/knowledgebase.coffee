exports.addTests = (suite) ->
    suite.path "/knowledgebase"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.checkOCS "Entries", "/data", "content", true

    suite.unpath()
