if typeof curl is 'undefined' # Load curl if using nodejs
  require '../bower_components/curl/dist/curl-for-ssjs/curl' 
  
curl
  paths:
    lib: '../bower_components'
