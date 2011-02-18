require 'rubygems'
require 'json'
require 'web_socket'

@sessid = ""
@ws = WebSocket.new "ws://grmbl.me:9957/socket.io/websocket"
puts "Connected to server"

def on_connect(id)
    @sessid = id
    @ws.send '1:101::/setprefs {"gender_set":false,"is_male":false,"wants_male":true,"wants_female":true,"wants_r":false},'
    @ws.send "1:5::/new,"
end

def on_convstart
end

def on_convend
    @ws.send "1:5::/new,"
end

def on_message(msg)
    if msg[:sender] != :self
        say msg[:message].reverse
    end
end

def say(something, len=something.length)
    @ws.send "1:#{len + 7}::/say #{something}\n,"
end

def parse(msg)
    h = {}
    if msg[0].chr == '0'
        h[:type] = :quit
    elsif msg[0].chr == '1'
        data = JSON.parse msg.split(':')[3..msg.length].join(':').chop
        if data['cmd'] == "connected"
            h[:type] = :conv_start
        elsif data['cmd'] == "them_msg"
            h[:type] = :message
            h[:sender] = :stranger
            h[:message] = data['data']
        elsif data['cmd'] == "you_msg"
            h[:type] = :message
            h[:sender] = :self
            h[:message] = data['data']
        elsif data['cmd'] == "convo_ended"
            h[:type] = :conv_end
        elsif data['cmd'] == "status"
            h[:type] = :status
            h[:message] = data['data']
        elsif data['cmd'] == "notice"
            h[:type] = :system
            h[:message] = data['data']
        elsif data['cmd'] == "nopartners"
            h[:type] = :nopartners
        end
    elsif msg[0].chr == '2'
        h[:type] = :heartbeat
        h[:data] = msg
    elsif msg[0].chr == '3'
        h[:type] = :sessid
        h[:value] = msg.split(':')[2].chop
    else
        h[:type] = :unknown
        h[:data] = msg
    end
    return h
end

while data = @ws.receive
    msg = parse(data)
    p msg
    if msg[:type] == :conv_start
        on_convstart
    elsif msg[:type] == :conv_end
        on_convend
    elsif msg[:type] == :sessid
        on_connect(msg[:value])
        puts @sessid
    elsif msg[:type] == :message
        on_message(msg)
    elsif msg[:type] == :heartbeat
        @ws.send msg[:data]
        puts "Responded to heartbeat"
    end
end
