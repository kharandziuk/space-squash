module.exports = (grunt) ->
  require('time-grunt')(grunt)
  require('load-grunt-tasks')(grunt)

  appConfig = grunt.file.readJSON('package.json')

  pathsConfig = (appName)->
    @app = appName || appConfig.name

    return {
      app: @app
      # assets
      clientCoffee: 'assets/coffee'
      serverCoffee: 'server/'
      less: 'assets/less'
      testsSrc: 'assets/tests'
      imgSrc: 'assets/images'

      # static
      bower: 'static/components'
      clientJS: 'static/js'
      serverJS: 'server/'
      imgDst: 'static/images'
      fonts: 'static/fonts'
      css: 'static/css'
      temlatesDst: 'static/js/tmpl'
      testsDst: 'static/js/tests'
    }

  grunt.initConfig({
    paths: pathsConfig(),
    pkg: appConfig,
    watch:
      grunt:
        files: ['Gruntfile.coffee']
      coffee:
        files: ['<%= paths.clientCoffee %>/**/*.coffee', '<%= paths.serverCoffee %>/**/*.coffee']
        tasks: ['coffee']
      less:
        files: ['<%= paths.less %>/**/*.less']
        tasks: ['less']
        options:
          nospawn: true
    bower:
      install:
        options:
          targetDir: '<%= paths.bower %>'
          layout: 'byComponent'
          #install: false
          verbose: false
          cleanTargetDir: true
          cleanBowerDir: false
          bowerOptions: {}
    less:
      development:
        options:
          paths: ['./assets/less'],
        files:
          {
            '<%= paths.css %>/app.css': '<%= paths.less %>/app.less',
            '<%= paths.css %>/base.css': '<%= paths.less %>/base.less'
          }
    coffee: {
      client:
        options:
          bare: true
        expand: true
        flatten: false
        cwd: '<%= paths.clientCoffee%>'
        src: ['**/*.coffee']
        dest: '<%= paths.clientJS %>'
        ext: '.js'
      #server:
      #  options:
      #    bare: true
      #  expand: true
      #  flatten: false
      #  cwd: '<%= paths.serverCoffee %>'
      #  src: ['**/*.coffee']
      #  dest: '<%= paths.serverJS %>'
      #  ext: '.js'
    }
  })
  grunt.registerTask('runApp', ()->require('./app'))

  grunt.registerTask('build', ['newer:coffee', 'newer:less', ])
  grunt.registerTask('server', ['build', 'runApp','watch'])
  grunt.registerTask('default', ['server'])
