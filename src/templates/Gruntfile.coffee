'use strict'

module.exports = (grunt)->

  # load all grunt tasks
  (require 'matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  _ = grunt.util._
  path = require 'path'

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    copy:
      main:
        files: [
          expand: true
          src: ['**']
          cwd: 'src/templates'
          dest: 'app/'
        ]
    coffeelint:
      gruntfile:
        src: '<%= watch.gruntfile.files %>'
      app:
        src: '<%= watch.app.files %>'
      options:
        no_trailing_whitespace:
          level: 'error'
        max_line_length:
          level: 'warn'
    coffee:
      app:
        expand: true
        cwd: 'src/'
        src: ['**/*.coffee']
        filter: (filepath) -> not filepath.match /^templates/
        dest: 'app'
        ext: '.js'
    watch:
      options:
        spawn: false
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['coffeelint:gruntfile']
      app:
        files: ['src/**/*.coffee']
        tasks: ['coffeelint:app', 'coffee:app']
    clean: ['app', 'test']

  grunt.event.on 'watch', (action, files, target)->
    grunt.log.writeln "#{target}: #{files} has #{action}"

    # coffeelint
    grunt.config ['coffeelint', target], src: files

    # coffee
    coffeeData = grunt.config ['coffee', target]
    files = [files] if _.isString files
    files = files.map (file)-> path.relative coffeeData.cwd, file
    coffeeData.src = files

    grunt.config ['coffee', target], coffeeData

  # tasks.
  grunt.registerTask 'compile', [
    'coffeelint'
    'coffee'
  ]

  grunt.registerTask 'default', [
    'compile'
    'copy'
  ]

