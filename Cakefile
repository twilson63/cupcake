{ exec } = require 'child_process'

task 'spec', ->
  exec 'jasmine-node spec --coffee', (err, stdout, stderr) ->
    console.log stdout.trim()
