# CupCake

Get a jumpstart to your express-coffee app!

[![Build Status](https://secure.travis-ci.org/twilson63/cupcake.png)](http://travis-ci.org/twilson63/cupcake)

## All about choice

* Choose your template engine (jade, eco, coffeekup, whiskers)
* Choose your datastore (redis, nano, mysql, mongoose, mongoskin)

## Cupcake automatically installs these modules for you:

* Connect Assets
* Stylus
* Nib

---

# Requirements

* nodejs >= 0.6

# Install

```
npm install cupcake -g
```

# Usage

```
cupcake [project name]

- choose your template
- choose your datastore
```
    
# Run your new project

``` sh
cd [project name]
npm install 
npm start

# Goto http://localhost:3000
```

# You have a working express app in coffee-script!

CupCake creates the following files for you to get hacking:

```
app.coffee
app.js
package.json
readme.md
public
  404.html
  robots.txt
assets
  js
    app.coffee
  css
    app.styl
views
  index.coffee
  layout.coffee
```

Don't forget to make adjustments to your Readme, and Package.js

# Test

``` sh
cake spec
```
# Contribute

Please send pull requests to continue to add, this is just the
beginning.  Lets make an awesome application template generator!

Thanks to :

- [@kadirpekel](https://github.com/coffeemate)
- [@kwindham](https://github.com/gradus)

[https://github.com/twilson63/cupcake/contributors](https://github.com/twilson63/cupcake/contributors)

# Feedback

Please post an issue or tweet [@jackhq](http://twitter.com/jackhq)

# Copyright

See LICENSE


