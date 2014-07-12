define [
  'marionette'
  'templates'
], (
  Marionette
  T
) ->


  class LoginView extends Backbone.ItemView
    template: T['login']

  class Hub extends Marionette.Controller

    initialize: ({region})->
      loginView = new LoginView
      region.show loginView
