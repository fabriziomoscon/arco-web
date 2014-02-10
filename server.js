var connect = require('connect')
  , http = require('http')
  , port = 9999
;

var app = connect()
  .use( connect.logger('dev') )
  .use( connect.static('public') )
  .use( connect.directory('public') )
;

http.createServer( app ).listen( port, function () {
  console.log( "Listening on port " + port );
} );
