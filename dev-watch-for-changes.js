var watch = require('watch')
  , dir = 'src/'
  , exec = require('child_process').exec
  , execMake
;

execMake = function() {

  var child = exec('make clean && make', function (error, stdout, stderr) {
    
    console.log("===========================================================>");
    console.log(stdout);
    
    if (error !== null) {
      console.log('make error: ' + error);
    }
  });

  return child;

}


watch.createMonitor( dir, function (monitor) {

  monitor.on("created", function (f, stat) {
    execMake();
  });

  monitor.on("changed", function (f, curr, prev) {
    execMake();
  });

  monitor.on("removed", function (f, stat) {
    execMake();
  });

});
