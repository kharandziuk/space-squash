define [
  'marionette'
  'templates'
  'io'
  'kineticjs'
  'game/game'
  'game/player'
  'game/ball'
  'game/opponent'
  'game/initStage'
], (
  Marionette
  T
  io
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

    onShow: ->
      socket = io.connect(window.location.origin)
      socket.on 'connect', ()->
        initStage 'board', socket
        socket.emit 'ready', {msg: 'ready'}


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

