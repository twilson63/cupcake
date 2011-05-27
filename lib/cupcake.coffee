sys = require 'sys'
eco = require 'eco'
fs = require 'fs'
ask = (require 'ask').ask

VERSION = '0.0.2'

ARTIFACTS = 
  framework:
    label: 'Web Framework'
    options: ['express',
#      'meryl',
#      'zappa'
    ]
  template:
    label: 'Template Engine'
    options: ['coffeekup', 'eco', 'jade']
  datastore:
    label: 'Data Store'
    options: ['mongoskin', 'redis', 'mysql']

prompt_for_artifacts = (callback) ->
  choices = {}
  i = 0
  keys = Object.keys ARTIFACTS
  prompt = ->
    if i == keys.length
      callback choices
      return
    key = keys[i]
    val = ARTIFACTS[key]
    console.log "What #{val.label} would you like?"
    for j, option of val.options
      index = parseInt(j) + 1
      console.log "#{index}. #{option}"
    ask 'Enter Number', /[0-9]/, (choice) =>
      option = val.options[parseInt(choice) - 1]
      if option
        choices[key] = option
        i += 1
      else
        console.error "Invalid choice"
      prompt()
      
  prompt()

render_template = (name, project) ->
  template = fs.readFileSync __dirname + "/../templates/#{name}.eco", "utf8"
  fs.writeFileSync "./#{project.name}/#{name}", eco.render(template, project)

build_folders = (project) ->
  # Create Project Dir
  fs.mkdirSync "./#{project.name}", 0755
  fs.mkdirSync "./#{project.name}/views", 0755
  fs.mkdirSync "./#{project.name}/public/", 0755
  fs.mkdirSync "./#{project.name}/public/stylesheets", 0755
  fs.mkdirSync "./#{project.name}/public/javascripts", 0755

build_files = (project) ->
  # Create Template Files
  render_template(name, project) for name in [
    'package.json'
    'app.js'
    'app.coffee'
    'readme.md'
    'Procfile'
  ]
  switch project.template
    when 'coffeekup'
      render_template(name, project) for name in [
        'views/layout.coffee'
        'views/index.coffee'
        'public/stylesheets/app.css'
        'public/javascripts/app.js'
      ]
    when 'eco'
      render_template(name, project) for name in [
        'views/layout.eco'
        'views/index.eco'
      ]
    when 'jade'
      render_template(name, project) for name in [
        'views/layout.jade'
        'views/index.jade'
      ]

thank_you = (project) ->
  console.log """
-----------------
Successfully created #{project.name}
To Run
cd #{project.name}
npm install .
coffee app.coffee
-----------------
You should nav to http://localhost:3000
-----------------
Thank you for using cupcake, please let us know if you have any problems
"""

exports.run = ->
  unless process.argv.length == 3
    console.log 'Please enter project name!' 
    return
  console.log "Welcome to Cupcake - #{VERSION}"
  project = {name: process.argv[2]}
  prompt_for_artifacts (choices) ->
    project =
      name: process.argv[2]
      framework: choices.framework
      template: choices.template
      datastore: choices.datastore
    console.log sys.inspect(project)
    build_folders project
    build_files project
    thank_you project
    process.exit()
