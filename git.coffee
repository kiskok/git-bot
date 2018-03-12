
HUBOT_DIR = "";
ALLOWED_USER="";

module.exports = (robot) ->

  robot.hear /git tag (.*)/i, (res) ->
    params = res.match[1].split " "

    if res.message.user.id != ALLOWED_USER
      return

    @exec = require('child_process').exec
    command = HUBOT_DIR + "/scripts/shell/tag.bat" + " " + params[0] + " " + params[1]
    res.send "Command: #{command}"

    @exec command, (error, stdout, stderr) ->
      if error
        res.send error
        res.send stderr
      else
        res.send stdout
        res.send "tag : " + params[1] + " is made in " + params[0];

  robot.hear /git deltag (.*)/i, (res) ->

    if res.message.user.id != ALLOWED_USER
      return

    params = res.match[1].split " "

    @exec = require('child_process').exec
    command = HUBOT_DIR + "/scripts/shell/deltag.bat" + " " + params[0] + " " + params[1]
    res.send "Command: #{command}"

    @exec command, (error, stdout, stderr) ->
      if error
        res.send error
        res.send stderr
      else
        res.send stdout
        res.send "tag : " + params[1] + " is deleted from " + params[0];

  robot.hear /help/i, (res) ->
    res.send "タグ作成\ngit tag {repo} {tagName}\nタグ削除\ngit deltag {repo} {tagName}\n※許可されたユーザからのみしか実行できません。"

