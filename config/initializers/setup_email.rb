require 'development_mail_interceptor'

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
#else
  #ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)                                                                                                                                                                                                                                                                                                     
end

