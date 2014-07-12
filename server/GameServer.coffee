socketio = require 'socket.io'

exports.listen = (server) ->
  io = socketio.listen(server)
  io.set('log level', 1)
  io.sockets.on('connection', (socket) ->
    console.log 'connected'
    socket.on('wait', (socket)->
      console.log 'wait', arguments
    )
  )

