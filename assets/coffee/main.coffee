require ['require-config'], ()->
  require(
    ['app'],
    (app)->
      app.start()
  )
