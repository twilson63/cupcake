var Cupcake, ask, eco, fs;

eco = require('eco');

fs = require('fs');

ask = require('ask');

Cupcake = (function() {

  function Cupcake() {}

  Cupcake.prototype.eco = eco;

  Cupcake.prototype.fs = fs;

  Cupcake.prototype.ask = ask;

  Cupcake.prototype.VERSION = '0.3.7';

  Cupcake.prototype.ROOT = ['package.json', 'server.js', 'app.coffee', 'readme.md', 'Procfile'];

  Cupcake.prototype.ARTIFACTS = {
    template: {
      label: 'Template Engine',
      options: ['jade', 'eco', 'coffeecup', 'whiskers']
    },
    datastore: {
      label: 'Data Store',
      options: ['redis', 'nano', 'mysql', 'mongoose', 'mongoskin']
    }
  };

  Cupcake.prototype.project = {
    name: 'foobar',
    framework: 'express',
    template: 'jade',
    datastore: 'request'
  };

  Cupcake.prototype.render_template = function(name, project) {
    var template;
    template = this.fs.readFileSync(__dirname + ("/../templates/" + name + ".eco"), "utf8");
    return this.fs.writeFileSync("./" + project.name + "/" + name, this.eco.render(template, project));
  };

  Cupcake.prototype.build_folders = function() {
    var directory, _i, _len, _ref, _results;
    _ref = ["./" + this.project.name, "./" + this.project.name + "/views", "./" + this.project.name + "/assets", "./" + this.project.name + "/assets/js", "./" + this.project.name + "/assets/css", "./" + this.project.name + "/public"];
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      directory = _ref[_i];
      _results.push(this.fs.mkdirSync(directory, 0755));
    }
    return _results;
  };

  Cupcake.prototype.build_files = function() {
    var name, template_name, _i, _j, _len, _len2, _ref, _ref2, _results;
    _ref = this.ROOT;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      name = _ref[_i];
      this.render_template(name, this.project);
    }
    template_name = this.project.template === 'coffeecup' ? 'coffee' : this.project.template;
    this.render_template("assets/js/app.coffee", this.project);
    this.render_template("assets/css/app.styl", this.project);
    this.render_template("public/404.html", this.project);
    this.render_template("public/robots.txt", this.project);
    _ref2 = ["views/layout." + template_name, "views/index." + template_name];
    _results = [];
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      name = _ref2[_j];
      _results.push(this.render_template(name, this.project));
    }
    return _results;
  };

  Cupcake.prototype.display_choices = function(val) {
    var index, j, option, _ref, _results;
    console.log("What " + val.label + " would you like?");
    _ref = val.options;
    _results = [];
    for (j in _ref) {
      option = _ref[j];
      index = parseInt(j) + 1;
      _results.push(console.log("" + index + ". " + option));
    }
    return _results;
  };

  Cupcake.prototype.thank_you = function() {
    return console.log("-----------------\nSuccessfully created " + this.project.name + "\nTo Run\n-----------------\ncd " + this.project.name + "\nnpm install\nnpm start\n-----------------\nYou should nav to http://localhost:3000\n-----------------\nThank you for using cupcake, please let us know if you have any problems");
  };

  Cupcake.prototype.prompt_for_artifacts = function(callback) {
    var choices, i, keys, prompt,
      _this = this;
    choices = {};
    i = 0;
    keys = Object.keys(this.ARTIFACTS);
    prompt = function() {
      var key, val;
      if (i === keys.length) return callback(choices);
      key = keys[i];
      val = _this.ARTIFACTS[key];
      _this.display_choices(val);
      return _this.ask('Enter Number', /[0-9]/, function(choice) {
        var option;
        option = val.options[parseInt(choice) - 1];
        if (option != null) {
          choices[key] = option;
          i++;
        } else {
          console.error("Invalid choice");
        }
        return prompt();
      });
    };
    return prompt();
  };

  Cupcake.prototype.run = function() {
    var project,
      _this = this;
    if (process.argv.length !== 3) {
      console.log('Please enter project name!');
      return;
    }
    console.log("Welcome to Cupcake - " + this.VERSION);
    project = {
      name: process.argv[2]
    };
    return this.prompt_for_artifacts(function(choices) {
      _this.project = {
        name: process.argv[2],
        framework: 'express',
        template: choices.template,
        datastore: choices.datastore
      };
      _this.build_folders();
      _this.build_files();
      _this.thank_you();
      return process.exit();
    });
  };

  return Cupcake;

})();

module.exports = new Cupcake;
