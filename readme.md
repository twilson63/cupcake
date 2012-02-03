# CupCake

Get a jumpstart to your express-coffee app!

## All about choice

* Choose your template engine (jade, eco, or coffeekup)
* Choose your datastore (nano, mysql, mongoose)

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
npm install .
coffee app.coffee

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


