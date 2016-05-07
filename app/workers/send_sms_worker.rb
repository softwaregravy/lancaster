class SendSmsWorker
  include Sidekiq::Worker

  # if something is going wrong, we don't want to send them a message on every retry
  sidekiq_options queue: :sms, retry: 0

  def perform(sms_message_attempt_id)
    attempt = SmsMessageAttempt.find(sms_message_attempt_id)
    ap attempt
    attempt.attempt_send
  end
end
