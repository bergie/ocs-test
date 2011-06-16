exports.addTests = (suite) ->
    suite.path "/friend"

    suite.discuss("Wrong method")
        .path("/activity")
        .get()
        .expect(404)
        .undiscuss()
        .unpath()

    suite.checkOCS "Received invitations", "/receivedinvitations", "user", true

    suite.checkOCS "Send invitations", "/sentinvitations", "user", true

    suite.unpath()
