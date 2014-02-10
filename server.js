var connect = require('connect')
  , http = require('http')
;

var app = connect()
  .use( connect.logger('dev') )
  .use( connect.static('public') )
  .use( connect.directory('public') )
;

http.createServer( app ).listen( 9999 );
