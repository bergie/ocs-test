http = require "http"
xml2js = require "xml2js"
url = require "url"
apiEasy = require "api-easy"
path = require "path"

providerURL = process.argv.pop()

getProvider = (providerURL, callback) ->
    uri = url.parse providerURL
    providerRequest =
        host: uri.hostname
        path: uri.pathname
        port: uri.port ? 80
        method: "GET"

    fetcher = http.request providerRequest, (res) ->
        unless res.statusCode is 200
            console.log "Provider file #{uri} returned error #{res.statusCode}"
            process.exit 1
        xml = ""
        res.setEncoding "utf-8"
        res.on "data", (data) ->
            xml += data
        res.on "end", ->
            parser = new xml2js.Parser()
            parser.on "end", (data) ->
                callback data
            parser.parseString xml
    fetcher.end()

getProvider providerURL, (providerData) ->
    provider = providerData.provider

    ocsURL = url.parse provider.location
    suite = apiEasy.describe "OCS provider #{provider.id} at #{provider.location}"
    suite.use ocsURL.hostname, ocsURL.port ? 80
    suite.root ocsURL.pathname

    for service, params of provider.services
        ocsVersion = "v#{params['@'].ocsversion.substr(0, 1)}"
        serviceTestFile = "#{__dirname}/#{ocsVersion}/#{service}.coffee"

        unless path.existsSync serviceTestFile
            console.log "Skipping tests for #{service} #{ocsVersion} because there are no tests for it"
            continue

        serviceTest = require serviceTestFile
        serviceTest.addTests suite

    suite.run
        reporter: require "vows/reporters/spec"
    , (results) ->
