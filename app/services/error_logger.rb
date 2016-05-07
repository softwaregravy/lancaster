class ErrorLogger

  class << self 
    def log_error(e = "Unspecified error")
      if e.respond_to?(:message) && e.respond_to?(:backtrace)
        logger.error e.message
        logger.error e.backtrace.join("\n")
      else 
        logger.error e.to_s 
      end
    end 
 
    def logger 
      Rails.logger
    end 
  end 
end 

