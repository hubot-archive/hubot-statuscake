# Description:
#   Send StatusCake status messages to your chat room.
#
# Dependencies:
#   "mustache" : "~0.8.1"

# Configuration:
#   STATUSCAKE_MESSAGE
#   STATUSCAKE_ROOM
#   STATUSCAKE_TOKEN
#     
# Commands:
#   None
#
# Notes:
#   STATUSCAKE_MESSAGE is the message that will be sent to your room. It is a Mustache string.
#   the following variables are available to you: name, url, status, statuscode, ip, token.
#   Read https://github.com/janl/mustache.js for more details. Default is set in DEFAULT_MESSAGE below.
#   Important note: HTML entities are encoded by Mustache by default, so if you don't want that, use
#   {{&somevar}} instead of {{somevar}}
#
#   STATUSCAKE_ROOM is the name of the room in which you want to send your statuses. Default is 'statuscake'.
#
#   STATUSCAKE_TOKEN is your user token. It is the MD5 sum of your username appended to your
#   API key. Default is ''.
#
# Author:
#   seabre

statuscake = require '../statuscake'

module.exports = (robot) ->
  # POST route to handle Ping URL sent from StatusCake.
  robot.router.post "/statuscake", (req, res) ->
    statuscake.handler req.body, robot
    res.end ""
