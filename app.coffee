express = require 'express'
bodyParser = require 'body-parser'
_ = require 'underscore'
app = express()

users = {}

app.use(bodyParser.json())

app.use('/static', express.static("#{__dirname}/static"))

app.get('/', (req, res) ->
  res.sendfile("#{__dirname}/index.html")
)

app.post('/login', (req, res)->
  data = req.body
  console.log data
  num = _.keys(users).length
  token = "token#{num}"
  users[token] = data.email
  data.token = token
  res.end(JSON.stringify data)
)

app.get('/login', (req, res)->
  console.log req.body
)

server = app.listen(3000)

chatServer = require('./server/GameServer')
chatServer.listen server
