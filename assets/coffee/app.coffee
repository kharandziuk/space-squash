define ['backbone', 'marionette', 'hub'], (Backbone, Marionette, Hub)  ->

  app = new Marionette.Application()

  API =
    startApp: ->
      hub = new Hub(region: app.mainRegion)

  app.navigate = (route, options) ->
    options || (options = {})
    Backbone.history.navigate(route, options)


  app.addRegions
    mainRegion: '#main-region'

  Router = Marionette.AppRouter.extend(
    appRoutes:
      '': 'startApp'
  )

  getCurrentRoute = () -> return Backbone.history.fragment

  app.addInitializer (options) ->
    new Router(controller: API)

  app.on('start', ()->
    if Backbone.history
      Backbone.history.start()
  )

  return app
