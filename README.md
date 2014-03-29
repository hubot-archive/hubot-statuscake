# hubot-statuscake

Send [StatusCake](http://www.statuscake.com) status messages to your organization's chat room via [Hubot](http://hubot.github.com/).

[![Build Status](https://travis-ci.org/seabre/hubot-statuscake.png?branch=master)](https://travis-ci.org/seabre/hubot-statuscake)


## Installation

Within your Hubot's repository, run `npm install hubot-statuscake --save`

Then, edit your `external-scripts.json` and add `"hubot-statuscake"` within the array. For instance, the contents of my `external-scripts.json` looks like:
```json
["hubot-statuscake"]
```

## Configuration

There are three environment variables: `STATUSCAKE_MESSAGE`, `STATUSCAKE_ROOM`, and `STATUSCAKE_TOKEN`.

`STATUSCAKE_MESSAGE` is the message that will be sent to your room. It is a Mustache string. The following variables are available to you: `name`, `url`, `status`, `statuscode`, `ip`, `token`.
Read https://github.com/janl/mustache.js for more details.

Important note: HTML entities are encoded by Mustache by default, so if you don't want that, use `{{&somevar}}` instead of `{{somevar}}`.

`STATUSCAKE_ROOM` is the name of the room in which you want to send your statuses. Default is `statuscake`.

`STATUSCAKE_TOKEN` is your user token. It is the MD5 sum of your username appended to your API key. This *must* be set. Otherwise, no messages will be sent. Default is an empty string.

# Tests

To run the test suite, you can checkout the repository and run `npm test`.

You can also run the test suite if the package is installed by running `npm test hubot-statuscake`.

# License

License is MIT. See `LICENSE` for more details.
