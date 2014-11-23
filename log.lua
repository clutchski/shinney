
local log = {} -- public interface

function log.logf(level, msg_fmt, ...)
    print(string.format("[%f %s] " .. msg_fmt, os.clock(), level, ...))
end

function log.infof(message, ...)
    log.logf("INFO", message, ...)
end

function log.debugf(message, ...)
    log.logf("DEBUG", message, ...)
end

return log
