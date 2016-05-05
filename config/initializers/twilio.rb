
# put your own credentials here
account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_ACCOUNT_AUTH_TOKEN']
if Rails.env.test?
  # This is Twilio's test number for sending SMS messages
  # https://www.twilio.com/docs/api/rest/test-credentials
  SmsMessage.from_number = '+15005550006'
else
  SmsMessage.from_number = ENV['TWILIO_FROM_NUMBER']
end

Twilio.configure do |config|
  config.account_sid = account_sid
  config.auth_token = auth_token
end

# @client = Twilio::REST::Client.new
