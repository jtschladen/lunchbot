# Description:
#   Because animals are animals.
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot animal me - Grab a random gif from http://animalsbeingdicks.com/
#
# Author:
#   unsay

Select     = require("soupselect").select
HtmlParser = require "htmlparser"

module.exports = (robot) ->
  robot.respond /animal me/i, (msg) ->
    randimalMe msg, (url) ->
      msg.send url

  robot.respond /puppy me/i, (msg) ->
    msg.send "www.randomdoggiegenerator.com/randomdoggie.php"
  #  rpuppyMe msg, (url) ->
  #    msg.send url

randimalMe = (msg, cb) ->
  msg.http("http://animalsbeingdicks.com/random")
    .get() (err, res, body) ->
      console.log res.headers.location
      animalMe msg, res.headers.location, (location) ->
        cb location 

rpuppyMe = (msg, cb) ->
  msg.http("http://openpuppies.com/")
    .get() (err, res, body) ->
      console.log res
      console.log res.headers
      console.log res.headers.location
      animalMe msg, res.headers.location, (location) ->
        cb location 

animalMe = (msg, location, cb) ->
  msg.http(location)
    .get() (err, res, body) ->
      handler = new HtmlParser.DefaultHandler()
      parser  = new HtmlParser.Parser handler

      parser.parseComplete body
      img = Select handler.dom, "#content .post .entry img"

      console.log img
      cb img[0].attribs.src