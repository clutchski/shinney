require "socket"
local logging = require "lib.logging"

local function listen()
    log = logging.init("server.log")
    local msgs = love.thread.getChannel("msgs")
    local sock = socket.udp()
    sock:setsockname('*', 3150)
    sock:settimeout(nil)

    log:info("Starting listener thread: %s", 3150)

    while (true) do
        msg, port = udpport:receivefrom(1024)
        msgs.push(msg)
    end
end

listen()
