define [
  'marionette'
], (
  Marionette
) ->

  class Hub extends Marionette.Controller

    initialize: ({region})->
      alert 'hub works'
