
local log = {} -- public interface

function log.log(level, msg_fmt, ...)
    msg = string.format(msg_fmt, ...)
    print(string.format("[%f %s] %s", os.clock(), level, msg))
end

function log.info(message, ...)
    log.log("INFO", message, ...)
end

function log.debug(message, ...)
    log.log("DEBUG", message, ...)
end


return log

