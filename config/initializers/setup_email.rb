require 'development_mail_interceptor'

gmail_settings = { 
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'gmail',
  user_name: 'john.development.test@gmail.com',
  password: ENV['EMAIL_PASSWORD'],
  authentication: 'plain',
  enable_starttls_auto: true
}

sendgrid_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}


if Rails.env.production?
  ActionMailer::Base.smtp_settings = sendgrid_settings
else
  ActionMailer::Base.smtp_settings = gmail_settings
end

#TODO currently restrict any live emails. When we're ready, we need to open up for production to actually send emails
unless Rails.env.production?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)                                                                                                                                                                                                                                                                                                     
end
