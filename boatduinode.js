var http = require('http');
<<<<<<< HEAD
var io = require('socket.io');
var express = require('express');

var app = express.createServer();

app.configure(function(){
    app.use(express.static(__dirname + '/public'));
});

app.get('/', function(req, res, next) {
    res.render('./public/index.html');
});
app.listen(8617);

var socket = io.listen(app, {
    flashPolicyServer: false,
    transports: ['websocket', 'htmlfile', 'xhr-multipart', 'xhr-polling', 'jsonp-polling']
    //transports: ['websocket']
});

socket.on('connection', function(client) {
    console.log("Connected");
    client.on('message', function(cmd) {
        client.broadcast(JSON.stringify(cmd));
        console.log(cmd);
    })

    client.on('disconnect', function() {

    })
});
=======
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\nApp (boatduinode) is running..');
}).listen(8617);
>>>>>>> 35234ccb07ae7934a5b974b1db955cd8a1401075
