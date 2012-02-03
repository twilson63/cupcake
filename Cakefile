{ exec } = require 'child_process'

task 'test', ->
  exec 'jasmine-node spec --coffee', (err, stdout, stderr) ->
    console.log stderr.trim()
    console.log stdout.trim()


task 'spec', ->
  exec 'jasmine-node spec --coffee', (err, stdout, stderr) ->
    console.log stderr.trim()
    console.log stdout.trim()
