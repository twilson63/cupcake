sys = require 'sys'
eco = require 'eco'
fs = require 'fs'
ask = (require 'ask').ask

class Cupcake
  ARTIFACTS: [
    { name: 'Web Framework', list:  ['1. Express', '2. Meryl', '3. Zappa']}
    { name: 'Template Engine', list:  ['1. Coffeekup','2. Eco', '3. Jade']}
    { name: 'DataStore', list:  ['1. MongoSkin','2. Redis', '3. MySql']}
  ]

  prompt: (artifact, list, callback) ->
    console.log "What #{artifact} would you like?"
    console.log option for option in list
    ask 'Enter Number', /[0-9]/, callback 

  build_meta: (data, callback) ->
    #@prompt @ARTIFACTS[0].name, @ARTIFACTS[0].list, (framework) =>
    data.framework = '1'
    @prompt @ARTIFACTS[1].name, @ARTIFACTS[1].list, (template) =>
      data.template = template
      @prompt @ARTIFACTS[2].name, @ARTIFACTS[2].list, (datastore) =>
        data.datastore = datastore
        callback data

  render_template: (name, data) ->
    template = fs.readFileSync __dirname + "/../templates/#{name}.eco", "utf8"
    fs.writeFileSync "./#{data.project}/#{name}", eco.render(template, data)

  build_folders: (project) ->
    # Create Project Dir
    fs.mkdirSync "./#{project}", 0755
    fs.mkdirSync "./#{project}/views", 0755

  build_files: (data) ->
    # Create Template Files
    @render_template(name, data) for name in [
      'package.json'
      'app.js'
      'app.coffee'
      'readme.md'
      'Procfile'
    ]
    if data.template is '1'
      @render_template(name, data) for name in [
        'views/layout.coffee'
        'views/index.coffee'
      ]
    else if data.template is '2'
      @render_template(name, data) for name in [
        'views/layout.eco'
        'views/index.eco'
      ]
    else if data.template is '3'
      @render_template(name, data) for name in [
        'views/layout.jade'
        'views/index.jade'
      ]
 


  thank_you: (project) ->
    console.log """
-----------------
Successfully created #{project}
To Run
cd #{project}
npm install .
coffee app.coffee
-----------------
You should nav to http://localhost:3000
-----------------
Thank you for using cupcake, please let us know if you have any problems
"""
    
  constructor: ->
    console.log 'Welcome to Cupcake - 0.0.2'
    project = process.argv.slice 2
    data = { project: project[0] }
    @build_meta data, (meta_data) =>
      console.log sys.inspect(meta_data)
      @build_folders meta_data.project
      @build_files meta_data
      @thank_you meta_data.project
      process.exit()
  

exports.run = ->
  unless process.argv.length == 3
    console.log 'Please enter project name!' 
    return
  new Cupcake





