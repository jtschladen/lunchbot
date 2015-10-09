# Description:
#   All by myself... :'(
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot alone - returns random alone gif
#
# Author:
#   Spencer

Select     = require("soupselect").select
HtmlParser = require "htmlparser"

module.exports = (robot) ->

  gif = ['https://s-media-cache-ak0.pinimg.com/originals/e6/bb/0e/e6bb0ed09fac49c43c49957aba9f43d9.gif',
         'http://media.giphy.com/media/tesOpJlQwEjQs/giphy.gif',
         'http://www.reactiongifs.us/wp-content/uploads/2014/08/pikachu_crying_pokemon.gif'
         'http://media2.giphy.com/media/jRl2V1AwJiSL6/giphy.gif'
         'http://stream1.gifsoup.com/view3/3659378/all-by-myself-o.gif']

  robot.hear /alone|solo|by myself|lonely/i, (res) ->
    user = res.message.user.name
    console.log "#{user} is alone"
    response = res.random gif
    res.send "#{response}"


