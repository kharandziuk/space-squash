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
    idArgument: 'email'
    

  class LoginView extends Marionette.ItemView
    template: T['login']

    events:
      "submit form": "formSubmitted"

    formSubmitted: (e)->
      console.log @
      e.preventDefault()
      data = Backbone.Syphon.serialize(this)
      @model.save(data).done((res)=>
        @model.set token: res.token
      ).fail(->
          alert 'fail'
      )


  class ListView extends Marionette.ItemView
    template: T['list']

    events:
      "submit form": "formSubmitted"

    formSubmitted: (e)->
      console.log @
      e.preventDefault()
      data = Backbone.Syphon.serialize(this)
      @model.save(data).done((res)=>
        @model.set token: res.token
      ).fail(->
          alert 'fail'
      )

  class Hub extends Marionette.Controller

    initialize: ({region})->
      @region = region
      @userModel = new LoginModel
      @showLoginView(@userModel)
      @userModel.on('change:token', =>
        @showListView()
      )

    showLoginView: (model)->
      loginView = new LoginView(model: @userModel)
      @region.show loginView

    showListView: ()->
      loginView = new ListView()
      @region.show loginView
      
