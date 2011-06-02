# CupCake

_Have a cupcake with your express, coffee and coffeekup_

A project generator for express and coffee-script.  

# About 0.0.7

* Choose your framework (express, meryl)
* Choose your template engine (coffeekup, eco, or jade)
* Choose your datastore (mongoskin, redis, or mysql)

---
Comes with client coffeescript and less ready to go out of the box.

# Requirements

* nodejs
* npm

# Install

    npm install cupcake -g

# Usage

    cupcake [project name]

    - choose your template
    - choose your datastore

    
# Run your new project

    cd [project name]
    npm install .
    coffee app.coffee

    # Goto http://localhost:3000

# You have a working express app in coffee-script!

CupCake creates the following files for you to get hacking:

app.coffee
app.js
package.json
readme.md
views
  index.coffee
  layout.coffee

Don't forget to make adjustments to your Readme, and Package.js

# Test

    cake spec

# Contribute

Please send pull requests to continue to add, this is just the
beginning.  Lets make an awesome application template generator!

Thanks to :

- [@kadirpekel](https://github.com/coffeemate)
- [@kwindham](https://github.com/gradus)

[https://github.com/twilson63/cupcake/contributors](https://github.com/twilson63/cupcake/contributors)


# Present - (Working)

As of 0.0.6

You now create an Express or Meryl project, with Coffeekup, Eco, or
Jade, and Mongoskin, Redis, or MySql.

Working on Zappa next....


# Future - (In Progress)

The plans is to prompt for type of framework, template, and data libs.
For example:

    cupcake my_project
    #
    Welcome to CupCake!

    What Framework would you like?
    1. Express
    2. Meryl
    3. Zappa

    What Template Engine would you like?
    1. CoffeeKup
    2. Eco
    3. Jade

    What DataStore would you like?
    1. MongoDb
    2. Redis
    3. MySql


# Feedback

Please post an issue or tweet [@jackhq](http://twitter.com/jackhq)

# License

See LICENSE


