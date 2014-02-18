util = require 'util'
path = require 'path'
url = require 'url'
npm = require 'npm'
chalk = require 'chalk'
yeoman = require 'yeoman-generator'

class GeneratorGogamatic extends yeoman.generators.Base
  constructor: (args, opts, conf) ->
    super
    @currentYear = (new Date()).getFullYear()
    @on 'end', => @installDependencies skipInstall: opts['skip-install']
    @pkg = JSON.parse @readFileAsString path.join __dirname, '../package.json'

  askFor: ->
    done = @async()
    console.log @yeoman
    console.log chalk.magenta 'Yeoman Gogamatic Generator'
    npm.load =>
      prompts = [
        name: 'name'
        message: 'Name'
        default: @appname
      ,
        name: 'description'
        message: 'Description'
        default: 'Gogamatic Scaffold'
      ,
        name: 'version'
        message: 'Version'
        default: '0.0.1'
      ,
        name: 'homepage'
        message: 'Homepage'
      ,
        name: 'license'
        message: 'License'
        default: 'MIT'
      ,
        name: 'username'
        message: 'Git Username'
        default: npm.config.get 'username'
      ,
        name: 'server'
        message: 'Git Server'
        default: 'github.com'
      ,
        name: 'author'
        message: 'Author\'s Name'
        default: npm.config.get 'init.author.name'
      ,
        name: 'email'
        message: 'Author\'s Email'
        default: npm.config.get 'init.author.email'
      ,
        name: 'home'
        message: 'Author\'s Homepage'
        default: npm.config.get 'init.author.url'
      ]

      @prompt prompts, (props) =>
        @[key] = props[key] for key in (p.name for p in prompts)
        @slug = @_.slugify @name
        @homepage ||= "https://#{@server}/#{@username}/#{@slug}"
        @repository = "https://#{@server}/#{@username}/#{@slug}.git"
        @private = false
        done()

  app: ->
    @mkdir 'app'
    @mkdir 'src'
    @mkdir "src/#{@slug}"
    @mkdir 'src/templates'

  files: ->
    @template '_package.json', 'package.json'
    @template '_bower.json', 'bower.json'
    @template '_README.md', 'README.md'
    @template '_main.coffee', 'src/main.coffee'
    @template '_index.coffee', 'src/index.coffee'
    @copy 'Gruntfile.coffee', 'Gruntfile.coffee'
    @copy 'editorconfig', '.editorconfig'
    @copy 'jshintrc', '.jshintrc'
    @copy 'npmignore', '.npmignore'
    @copy 'gitignore', '.gitignore'

module.exports = GeneratorGogamatic
