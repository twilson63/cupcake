eco = require 'eco'
fs = require 'fs'

render_template = (name, data) ->
  template = fs.readFileSync __dirname + "/../templates/#{name}.eco", "utf8"
  fs.writeFileSync "./#{data.project}/#{name}", eco.render(template, data)
  
 

exports.run = ->
  unless process.argv.length == 3
    console.log 'Please enter project name!' 
    return

  console.log 'Welcome to Cupcake'
  project = process.argv.slice 2
  data = { project: project }

  # Create Project Dir
  fs.mkdirSync "./#{project}", 0755
  fs.mkdirSync "./#{project}/views", 0755

  # Create Template Files
  render_template(name, data) for name in [
    'package.json'
    'app.js'
    'app.coffee'
    'readme.md'
    'Procfile'
    'views/layout.coffee'
    'views/index.coffee'
  ]

  console.log "Successfully created #{project}"
  console.log "To Run"
  console.log "cd #{project}"
  console.log "npm install ."
  console.log "coffee app.coffee"
  console.log "-----------------"
  console.log "You should nav to http://localhost:3000"




