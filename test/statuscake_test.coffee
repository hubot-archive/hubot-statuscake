chai = require 'chai'

expect = chai.expect

statuscake =  require '../src/statuscake'

describe 'statuscake', ->

  beforeEach ->
    @unsanitizedbody =
      Token: ""
      Status: "Up"
      StatusCode: 200
      URL: "http://www.google.com"
      IP: "127.0.0.1"
      Name: "Test"

    @unsanitizedbadbody =
      Token: "12345"
      Status: "Up"
      StatusCode: 200
      URL: "http://www.google.com"
      IP: "127.0.0.1"
      Name: "Test"

    @body =
      token: ""
      status: "Up"
      statuscode: 200
      url: "http://www.google.com"
      ip: "127.0.0.1"
      name: "Test"

    # Mock for robot
    @robot =
      messageRoom: (room, message) ->
        result =
          room: room
          message: message
        result

    @expectedRenderedOutput = "Test ( http://www.google.com ) is now Up with a status code of 200."

  describe '#isAuthenticResponse', ->
    it "returns false if the token is not the same as the default that is currently set", ->
      expect(statuscake.isAuthenticResponse("test")).to.equal(false)

    it "returns true if the token is the same as the default that is currently set", ->
      expect(statuscake.isAuthenticResponse("")).to.equal(true)

  describe '#sanitizeBody', ->
    beforeEach ->
      @o = {}
    it "returns an empty string for token if token is undefined", ->
      expect(statuscake.sanitizeBody(@o).token).to.equal("")

    it "returns an empty string for status if token is undefined", ->
      expect(statuscake.sanitizeBody(@o).status).to.equal("")

    it "returns an empty string for statuscode if token is undefined", ->
      expect(statuscake.sanitizeBody(@o).statuscode).to.equal("")

    it "returns an empty string for url if token is undefined", ->
      expect(statuscake.sanitizeBody(@o).url).to.equal("")

    it "returns an empty string for ip if token is undefined", ->
      expect(statuscake.sanitizeBody(@o).ip).to.equal("")

    it "returns an empty string for name if token is undefined", ->
      expect(statuscake.sanitizeBody(@o).name).to.equal("")

    it "returns an object with token if the unsanitized object has Token", ->
      expect(statuscake.sanitizeBody(@unsanitizedbody).token).to.equal("")

    it "returns an object with status if the unsanitized object has Status", ->
      expect(statuscake.sanitizeBody(@unsanitizedbody).status).to.equal("Up")

    it "returns an object with statuscode if the unsanitized object has StatusCode", ->
      expect(statuscake.sanitizeBody(@unsanitizedbody).statuscode).to.equal(200)

    it "returns an object with url if the unsanitized object has URL", ->
      expect(statuscake.sanitizeBody(@unsanitizedbody).url).to.equal("http://www.google.com")

    it "returns an object with ip if the unsanitized object has IP", ->
      expect(statuscake.sanitizeBody(@unsanitizedbody).ip).to.equal("127.0.0.1")

    it "returns an object with name if the unsanitized object has Name", ->
      expect(statuscake.sanitizeBody(@unsanitizedbody).name).to.equal("Test")
      

  describe '#renderStatusMessage', ->

    it "returns a rendered string from statusCakeMessage", ->
      expect(statuscake.renderStatusMessage(@body)).to.equal(@expectedRenderedOutput)

  describe '#sendStatusMessage', ->

    it "sends the message to the desired room", ->
      expect(statuscake.sendStatusMessage(@robot, "test", @body).room).to.equal("test")

    it "sends the mustache rendered message to the room", ->
      expect(statuscake.sendStatusMessage(@robot, "test", @body).message).to.equal(@expectedRenderedOutput)

  describe '#handler', ->

    it "returns undefined if the token does not match", ->
      expect(statuscake.handler(@unsanitizedbadbody, @robot)).to.equal(undefined)

    it "calls sendStatusMessage and sends it to the default room", ->
      expect(statuscake.handler(@unsanitizedbody, @robot).room).to.equal('statuscake')

    it "calls sendStatusMessage and sends the rendered message", ->
      expect(statuscake.handler(@unsanitizedbody, @robot).message).to.equal(@expectedRenderedOutput)
