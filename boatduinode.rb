# Copyright (C) 2011 by ath (@supertunaman)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'rubygems'
require 'serialport'
require 'web_socket'

@serial = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)
#@ws = WebSocket.new "ws://localhost:8080/socket.io/websocket"
@ws = WebSocket.new "ws://boatduinode.nodester.com:80/socket.io/websocket"
puts "Connected"

def up
    stop
    @serial.print "LR"
end

def down
    stop
    @serial.print "lr"
end

def left
    stop
    @serial.print "lR"
end

def right
    stop
    @serial.print "Lr"
end

def stop
    @serial.print "S"
end

last_cmd = "stop"

while data = @ws.receive
    if data.include? last_cmd
        next
    elsif data.include? "up"
        up
        last_cmd = "up"
    elsif data.include? "down"
        down
        last_cmd = "down"
    elsif data.include? "left"
        left
        last_cmd = "left"
    elsif data.include? "right"
        right
        last_cmd = "right"
    elsif data.include? "stop"
        stop
        last_cmd = "stop"
    else
        @ws.send data
    end

    puts data 
end
