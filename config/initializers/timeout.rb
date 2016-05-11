# timeout requests over 20 seconds
Rack::Timeout.service_timeout = 20  # seconds
Rack::Timeout::Logger.level  = Logger::WARN

