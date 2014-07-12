define [
  'marionette'
  'templates'
], (
  Marionette
  T
) ->

  require(['backbone.syphon'])

  class LoginModel extends Backbone.Model
    url: 'login'

  class LoginView extends Marionette.ItemView
    template: T['login']

    events:
      "submit form": "formSubmitted"

    formSubmitted: (e)->
      console.log @
      e.preventDefault()
      data = Backbone.Syphon.serialize(this)
      console.log data
      @model.set(data)


  class Hub extends Marionette.Controller

    initialize: ({region})->
      loginModel = new LoginModel
      loginView = new LoginView(model: loginModel)
      region.show loginView
      loginModel.on('change', ->
         @save()
      )
