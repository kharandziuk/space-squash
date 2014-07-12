express = require('express')
app = express()

app.use('/static', express.static("#{__dirname}/static"))

app.get('/', (req, res) ->
  res.sendfile("#{__dirname}/index.html")
)

app.post('/login', (req, res) ->
  console.log req
)

server = app.listen(3000)

chatServer = require('./server/GameServer')
chatServer.listen server
