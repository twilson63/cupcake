class Cupcake
  VERSION: '0.0.8'

  ROOT: [
    'package.json'
    'app.js'
    'app.coffee'
    'readme.md'
    'Procfile'
  ]

  ARTIFACTS: 
    framework:
      label: 'Web Framework'
      options: ['express',
        'meryl',
        'coffeemate'
      ]
    template:
      label: 'Template Engine'
      options: ['coffeekup', 
        #'eco', 
        'jade']
    datastore:
      label: 'Data Store'
      options: ['mongoskin', 'redis', 'mysql']
  
  sys: require 'sys'
  eco: require 'eco'
  fs: require 'fs'
  ask: (require 'ask').ask
  project: 
    name: 'foobar'
    framework: 'express'
    template: 'coffeekup'
    datastore: 'mongoskin'

  render_template: (name, project) ->
    template = @fs.readFileSync __dirname + "/../templates/#{name}.eco", "utf8"
    @fs.writeFileSync "./#{project.name}/#{name}", @eco.render(template, project)

  build_folders: ->
    @fs.mkdirSync directory, 0755 for directory in [
      "./#{@project.name}"
      "./#{@project.name}/views"
      "./#{@project.name}/public"
      "./#{@project.name}/public/stylesheets"
      "./#{@project.name}/public/javascripts"
    ]

  build_files: ->
    # Create Template Files
    @render_template(name, @project) for name in @ROOT
    template_name = if @project.template == 'coffeekup' then 'coffee' else @project.template

    @render_template(name, @project) for name in [
      "views/layout.#{template_name}"
      "views/index.#{template_name}"
    ]

  display_choices: (val) ->
    console.log "What #{val.label} would you like?"
    for j, option of val.options
      index = parseInt(j) + 1
      console.log "#{index}. #{option}"

  thank_you: ->
    console.log """
-----------------
Successfully created #{@project.name}
To Run
cd #{@project.name}
npm install .
coffee app.coffee
-----------------
You should nav to http://localhost:3000
-----------------
Thank you for using cupcake, please let us know if you have any problems
"""

  prompt_for_artifacts: (callback) ->
    # init locals
    choices = {}
    i = 0
    keys = Object.keys @ARTIFACTS

    # setup recursion
    prompt = =>
      return callback(choices) if i == keys.length
      key = keys[i]
      val = @ARTIFACTS[key]
      @display_choices val

      @ask 'Enter Number', /[0-9]/, (choice) =>
        option = val.options[parseInt(choice) - 1]
        if option?
          choices[key] = option
          i++
        else
          console.error "Invalid choice"
        prompt()
    prompt()

  run: ->
    unless process.argv.length == 3
      console.log 'Please enter project name!' 
      return

    console.log "Welcome to Cupcake - #{@VERSION}"
    project = {name: process.argv[2]}
    @prompt_for_artifacts (choices) =>
      @project =
        name: process.argv[2]
        framework: choices.framework
        template: choices.template
        datastore: choices.datastore
      #console.log sys.inspect(project)
      @build_folders()
      @build_files()
      @thank_you()
      process.exit()

exports.cupcake = new Cupcake



