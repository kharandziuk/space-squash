define ['backbone', 'marionette'], (Backbone, Marionette)  ->

  app = new Marionette.Application()

  API =
    startApp: ()->
      alert 'app start'

  app.navigate = (route, options) ->
    options || (options = {})
    Backbone.history.navigate(route, options)

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
