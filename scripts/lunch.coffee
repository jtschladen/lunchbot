# Description:
#   Because I'm hungry.
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot which floor - returns a random floor, '4th' or '5th'
#
# Author:
#   Jasmine

Select     = require("soupselect").select
HtmlParser = require "htmlparser"

module.exports = (robot) ->
  robot.respond /which floor2/i, (msg) ->
    randFloor msg, (url) ->
      msg.send url

randFloor = (msg, cb) ->
  msg.http("https://www.random.org/integers/?num=1&min=4&max=5&format=plain&rnd=new&col=1&base=10”)
    .get() (err, res, body) ->
      console.log res.headers.location
      floorMe msg, res.headers.location, (location) ->
        cb location

floorMe = (msg, location, cb) ->
  msg.http(location)
    .get() (err, res, body) ->
      handler = new HtmlParser.DefaultHandler()
      parser  = new HtmlParser.Parser handler

      parser.parseComplete body
      img = Select handler.dom, "#content .post .entry img"

      console.log img
      cb img[0].attribs.src