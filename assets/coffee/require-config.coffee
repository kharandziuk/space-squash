LIB = '../components'

fromLib = (dir, name) ->
  name = name or dir
  return "#{LIB}/#{dir}/#{name}"


require.config(
  urlArgs: "bust=" + (new Date()).getTime()
  paths:
    backbone : fromLib 'backbone'
    underscore : fromLib 'underscore'
    jquery : fromLib 'jquery', 'dist/jquery'
    marionette : fromLib 'marionette/lib', 'backbone.marionette'
    handlebars: fromLib 'handlebars', 'handlebars'
    hbs: fromLib 'require-handlebars-plugin', 'hbs'
    'backbone.wreqr' : fromLib 'backbone.wreqr/lib', 'backbone.wreqr'
    'backbone.eventbinder' : fromLib 'backbone.eventbinder/lib/amd', 'backbone.eventbinder'
    'backbone.babysitter' : fromLib 'backbone.babysitter/lib/amd','backbone.babysitter'
    'backbone.picky': fromLib 'backbone.picky/lib', 'backbone.picky'
    'backbone.syphon': fromLib 'backbone.syphon/lib', 'backbone.syphon'
  shim:
    handlebars:
      exports: 'Handlebars'
    tooltip:
      deps: ['jquery']
    underscore :
      exports : '_'
    backbone :
      deps : ['jquery', 'underscore']
      exports : 'Backbone'
    marionette:
      deps: ['backbone']
      exports: 'Marionette'
    'backbone.picky':
      deps: ['backbone']
    'backbone.syphon':
      deps: ['backbone']
)
