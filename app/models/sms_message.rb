# == Schema Information
#
# Table name: sms_messages
#
#  id              :integer          not null, primary key
#  send_initiated  :datetime
#  send_completed  :datetime
#  retry_enabled   :boolean          default("true"), not null
#  max_attempts    :integer          default("1"), not null
#  user_id         :integer          not null
#  notification_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class SmsMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification
  has_many :sms_message_attempts

  # watch out, send is keyword in ruby :)
  def execute_send
    record_start_time
    queue_attempt
  end

  def record_start_time
    self.send_initiated = DateTime.now
    self.save!
  end

  def queue_attempt
    attempt = SmsMessageAttempt.create!(sms_message: self)
    SendSmsWorker.perform_async(attempt.id)
  end

  def succeeded!
    self.send_completed = DateTime.now
    self.save!
  end

  def failed!
    queue_attempt if retry_enabled && sms_message_attempts.count < max_attempts 
  end

end
