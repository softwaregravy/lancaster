require 'development_mail_interceptor'

gmail_settings = { 
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'gmail',
  user_name: 'john.development.test@gmail.com',
  password: ENV['DEVELOPMENT_EMAIL_PASSWORD'],
  authentication: 'plain',
  enable_starttls_auto: true
}

ActionMailer::Base.smtp_settings = gmail_settings

#TODO currently restrict any live emails. When we're ready, we need to open up for production to actually send emails
if true
# if Rails.env.development? || Rails.env.test?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)                                                                                                                                                                                                                                                                                                     
end
