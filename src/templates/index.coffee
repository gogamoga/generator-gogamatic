if typeof curl is 'undefined' # Load curl if using nodejs
  require '../bower_components/curl/dist/curl-for-ssjs/curl' 

config =   
  baseUrl: 'app'
  paths:
    lib: '../bower_components'
  packages: [
  # App level packages
    name: "<%= slug %>"
    location: "app/<%= slug %>"
  ,
  # Vendor packages
    name: 'curl'
    location: 'lib/curl/src/curl'
  ,
    name: 'poly'
    location: 'lib/poly'
  ,
    name: 'meld'
    location: 'lib/meld'
    main: 'meld'
  ,  
    name: 'when'
    location: 'lib/when'
    main: 'when'
  ,
    name: 'wire'
    location: 'lib/wire'
    main: 'wire'
  ]
  locale: false
  preloads: ['poly/all']
  
(curl config, ['wire!app/main']).then success, failure

success: -> # Startup task

failure: -> # Abort startup

  
  

