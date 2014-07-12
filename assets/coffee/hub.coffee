define [
  'Game'
  'marionette'
  'templates'
  'io'
  'backbone.picky'
  'kineticjs'
  'game/game'
  'game/player'
  'game/ball'
  'game/opponent'
  'game/initStage'
], (
  Game
  Marionette
  T
  io
) ->
  require(['backbone.syphon'])

  class LoginModel extends Backbone.Model
    url: 'login'
    idArgument: 'email'

  class GamesInList extends Backbone.Model
    initialize: ->
      selectable = new Backbone.Picky.Selectable(@)
      _.extend(@, selectable)# mixing Selectable behaviour
             

  class GamesCollection extends Backbone.Collection
    model: GamesInList
    initialize: ->
      singleSelect = new Backbone.Picky.SingleSelect @
      _.extend(@, singleSelect)
    url: 'list'
    parse: (resp)->
      arr = _.pairs(resp)
      arrRes = _.map(arr, (el)->
        {
          title: el[1]
          token: el[0]
        }
      )
      return arrRes

    
  class LoginView extends Marionette.ItemView
    template: T['login']

    events:
      "submit form": "formSubmitted"

    formSubmitted: (e)->
      e.preventDefault()
      data = Backbone.Syphon.serialize(this)
      @model.save(data).done((res)=>
        @model.set token: res.token
      ).fail(->
          alert 'fail'
      )

  class GameInListView extends Marionette.ItemView
    template: Handlebars.compile("{{title}}")
    tagName: 'li'

    events:
      'click': ->
        @model.select()


  class ListView extends Marionette.CompositeView
    template: T['list']
    itemContainer: ".games-list"
    itemView: GameInListView

  class GameLayout extends Marionette.Layout
    template: T['layout']

    regions:
      list: ".list"
      form: ".form"

  class GameView extends Marionette.ItemView
    template: T['game']
    initialize: ({model, game})->
      @game = game
      
    onShow: ->
      {host, token} = @model.attributes
      initStage 'board',  @game.socket
      console.assert host?
      if host
        @game.wait(token)
      else
        @game.join(token)


  class Hub extends Marionette.Controller

    initialize: ({region})->
      @region = region
      @userModel = new LoginModel
      @showLoginView(@userModel)
      @userModel.on('change:token', (model)=>
        model.set host: true
        @showGame(model: model)
      )

    showLoginView: (model)->
      @layout = new GameLayout()
      @region.show @layout
      loginView = new LoginView(model: @userModel)
      @layout.form.show loginView
      games = new GamesCollection()
      games.fetch()
      listView = new ListView(collection: games)
      @layout.list.show listView
      games.on('select:one', (model)=>
        model.set host: false
        @showGame(model: model)
      )

    showGame: ({model})->
      socket = io.connect()
      game = new Game(socket)
      gameView = new GameView(model: model, game: game)
      @region.show gameView
