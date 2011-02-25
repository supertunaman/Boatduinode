var http = require('http');
var io = require('socket.io');
var express = require('express');

var app = express.createServer();

app.configure(function(){
    app.use(express.staticProvider(__dirname + '/public'));
});

app.get('/', function(req, res, next) {
    res.render('./public/index.html');
});
app.listen(8167);

var socket = io.listen(app, {
    flashPolicyServer: false,
    transports: ['websocket', 'htmlfile', 'xhr-multipart', 'xhr-polling', 'jsonp-polling']
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
