var watch = require('watch')
  , dir = 'src/'
  , exec = require('child_process').exec
  , execMake
;

execMake = function( filename, clean ) {

  console.log( 'make: ' + filename );

  var cmd = "make coffee-compile filename=" + filename;
  if ( clean == true) {
    cmd = "make clean filename=" + filename + " && " + cmd
  }

  var child = exec(cmd, function (error, stdout, stderr) {
    
    console.log("===========================================================>");
    console.log(stdout);
    
    if (error !== null) {
      console.log('make error: ' + error);
    }
  });

  return child;

}


watch.createMonitor( dir, function (monitor) {

  monitor.on("created", function (filename, stat) {
    execMake( filename, false );
  });

  monitor.on("changed", function (filename, curr, prev) {
    execMake( filename, true );
  });

  monitor.on("removed", function (filename, stat) {
    execMake( filename, true );
  });

});
