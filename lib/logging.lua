
require "logging.file"

local log = {} -- public interface

function log.init(path)
  thread = tostring( {} ):sub(8)
  fmt = "[" .. thread .. "] %date %level %message\n"
  log.logger = logging.file(path, "", fmt)
  return log.logger
end

function log.get()
  return log.logger
end

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
