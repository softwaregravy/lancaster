class SendSmsWorker
  include Sidekiq::Worker

  sidekiq_options queue: :sms

  def perform(sms_message_attempt_id)
    attempt = SmsMessageAttempt.find(sms_message_attempt_id)
    attempt.attempt_send
  end
end
