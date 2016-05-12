class DevelopmentMailInterceptor                                                                                                                                                                                                                                                                                                                                          
  TESTING_EMAIL = 'no-reply@sample.com'

  def self.delivering_email(message)
    return if Rails.env.test?
    message.subject = "#{message.to} #{message.subject}"
    message.to = TESTING_EMAIL
    if message.cc.present?
      message.subject << " [cc: #{message.cc}]"
      message.cc = nil 
    end 
    if message.bcc.present?
      message.subject << " [bcc: #{message.bcc}]"
      message.bcc = nil 
    end 
  end 
end

