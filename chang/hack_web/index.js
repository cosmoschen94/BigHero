var	express = require('express'),
	app = require('express')(),						// start Express framework
  	server = require('http').createServer(app);

console.log("opening serial port: " + "/dev/tty.usbserial");
server.listen(8080, '0.0.0.0');								// listen for incoming requests on the server
console.log("Listening for new clients on port 8080");

app.use(express.static('resources'));

app.get('/', function (request, response) {
  response.sendFile(__dirname + '/index.html');
  console.log("send response");
});



