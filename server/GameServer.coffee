socketio = require 'socket.io'

games = []
tokens = {}

handleDisconnection = (socket) ->
  socket.on('disconnect', ()->
    console.log 'disconnect: ', socket.id
  )

# handleNameChangeAttempts

handleMessageBroadcasting = (socket) ->
  socket.on 'message', (message) ->
    socket.broadcast.to(message.room).emit('message',
      text: "#{nickNames[socket.id]}: #{message.text}"
    )
# handleMessageBroadcasting

handleJoining = (socket, io) ->
  socket.on('join', ({token}) ->
    console.assert token in games
    socket.join 1
    console.log 'join', token
    socket.broadcast.to(1).emit 'ready', {}
  )

handleHosting = (socket) ->
  socket.on('wait', ({token}) ->
    games.push(token)
    console.log 'wait', token
    socket.join 1
  )
  socket.on('ready', ->
    console.log 'meet each other'
  )



exports.listen = (server) ->
  io = socketio.listen(server)
  io.set('log level', 1)
  io.on 'connection', (socket) ->
    handleHosting socket, io
    handleJoining socket, io
    handleDisconnection(socket)
    return


