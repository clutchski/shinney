
require "socket"

local logging = require "lib.logging"

function love.load()
    local log = logging.init("server.log")
    log:info("Starting game")

    msgs = love.thread.getChannel("msgs")
    listener = love.thread.newThread("listener.lua")
    listener:start()

    local addr = socket.dns.toip(socket.dns.gethostname())
    log:info("Starting server: %s", addr)
end

function love.draw()
end

function love.update(dt)
    msg = msgs:pop()
    if (msg) then
        log.infof("got msg: %s", msg)
    end
end
