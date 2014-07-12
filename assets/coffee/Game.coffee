define [], ->

  class Game

    constructor: (@socket)->

    wait: (token)->
      @socket.emit('wait', {token: token})

    join:(token)->
      @socket.emit('join', {token: token})

    processCommand:(command)->
      return message

  return Game
