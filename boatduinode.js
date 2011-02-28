/* Copyright (C) 2011 by ath (@supertunaman)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE. */

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
app.listen(8617);

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
