require ['require-config'], ()->
  require(
    ['io'],
    (io)->
      io.connect()
  )
