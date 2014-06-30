var connect = require('connect');
var express = require('express');
var app = express();
var PORT = 9999;

app.use( connect.logger('dev') );
app.use( express.static(__dirname + '/public') );

app.use( function(req, res, next) {
  res.sendfile(__dirname + '/public/index.html');
});

app.listen( PORT, function() {
  console.log( "Listening on port " + PORT );
});
