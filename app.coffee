express = require('express')
app = express()

app.use('/static', express.static(__dirname + '/static'))

app.get('/', (req, res)->
  res.send('Hello World')
)

app.listen(3000)
