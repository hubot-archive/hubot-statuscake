mustache = require 'mustache'

DEFAULT_MESSAGE = '{{&name}} ( {{&url}} ) is now {{status}} with a status code of {{statuscode}}.'
DEFAULT_ROOM = 'statuscake'

statusCakeMessage = process.env.STATUSCAKE_MESSAGE or DEFAULT_MESSAGE
statusCakeRoom = process.env.STATUSCAKE_ROOM or DEFAULT_ROOM
statusCakeToken = process.env.STATUSCAKE_TOKEN or ""

# Does request token actually match yours?
exports.isAuthenticResponse = (token) ->
  token == statusCakeToken

# Take the request body and return an object with the keys and their values.
exports.sanitizeBody = (body) ->
  result =
    token: body.Token or ""
    status: body.Status or ""
    statuscode: body.StatusCode or ""
    url: body.URL or ""
    ip: body.IP or ""
    name: body.Name or ""

  result

# Render the mustache-formatted status string.
exports.renderStatusMessage = (body) ->
  mustache.render statusCakeMessage, body

# Simple request handler, mainly for the status cake route.
# Do nothing if the token sent with the POST request does not
# match what we have.
exports.handler = (body, robot) ->
  sanitizedBody = @sanitizeBody(body)
  if @isAuthenticResponse(sanitizedBody.token)
    @sendStatusMessage robot, statusCakeRoom, sanitizedBody

# Send the status message to the desired room.
exports.sendStatusMessage = (robot, room, body) ->
  robot.messageRoom room, @renderStatusMessage(body)
