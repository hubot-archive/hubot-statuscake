chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'hubot-statuscake', ->
  beforeEach ->
    @robot =
      router:
        post: sinon.spy()

    require('../src/hubot/hubot-statuscake')(@robot)

  it "has a '/statuscake' POST route", ->
    expect(@robot.router.post).to.have.been.calledWith("/statuscake")
