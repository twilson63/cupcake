
db = require 'redis'


express = require('express')
app = express.createServer()

# Setup Template Engine

app.register '.jade', require('jade')
app.set 'view engine', 'jade'


# Setup Static Files
app.use express.static(__dirname + '/public')

# App Routes
app.get '/', (req, resp) ->
  resp.render 'index', title: 'Awesome Sauce'
  
# Listen
app.listen 3000


