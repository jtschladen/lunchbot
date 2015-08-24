
module.exports = (robot) ->

 floors = ['4th', '5th']

 lastFloor = null

 savedDate = null

 askCount = null

 robot.hear /which floor/i, (res) ->
  user = res.message.user.name
  now = new Date()
  nowDateMonth = "#{now.getFullYear()} #{now.getMonth()} #{now.getDate()}"
  if now and savedDate
    moreThanADayAgo = savedDate != nowDateMonth
  if lastFloor and savedDate and !moreThanADayAgo
    askCount += 1
    if askCount > 2
     sarcasticResponses = ["#{lastFloor} floor, and don’t ask me again.", "You should go eat on floor 666!", "Do you really need to eat today?", "Eating is for the weak!", "You must have the mental capacity of a goldfish. I already told you #{lastFloor} floor.", "Eat on floor #{lastFloor} and 3/4.", "You should eat at your desk alone because I don’t want to say it again http://s.quickmeme.com/img/11/11af033ca528b880096cd9ba73adb30ff4f27ec053473fc3f4c5cac981ee4c21.jpg"]
     response = res.random sarcasticResponses
     res.send "#{response}"
    else
     res.send "I already answered this, @#{user}! Eat on the #{lastFloor} floor today."
  else
   lastFloor = res.random floors
   savedDate = nowDateMonth
   askCount = 1
   res.send "You should eat on the #{lastFloor} floor today."

 robot.hear /reset floor/i, (res) ->
  lastFloor = null
  res.send "Okay, I reset the floor for you."