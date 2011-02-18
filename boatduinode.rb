require 'rubygems'
require 'serialport'
require 'web_socket'

@serial = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)
#@ws = WebSocket.new "ws://localhost:8080/socket.io/websocket"
@ws = WebSocket.new "ws://boatduinode.nodester.com/socket.io/websocket"
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
