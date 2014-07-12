express = require 'express'
bodyParser = require 'body-parser'
app = express()

app.use(bodyParser.json())

app.use('/static', express.static("#{__dirname}/static"))

app.get('/', (req, res) ->
  res.sendfile("#{__dirname}/index.html")
)

app.post('/login', (req, res) ->
  console.log req.body
)

server = app.listen(3000)

chatServer = require('./server/GameServer')
chatServer.listen server
