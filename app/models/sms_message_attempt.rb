# == Schema Information
#
# Table name: sms_message_attempts
#
#  id             :integer          not null, primary key
#  attempted      :datetime
#  successful     :boolean          default("false"), not null
#  to_number      :string           not null
#  from_number    :string           not null
#  body           :string           not null
#  sms_message_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class SmsMessageAttempt < ActiveRecord::Base
  class << self
    # not really a good place for this ...
    attr_accessor :from_number
  end

  belongs_to :sms_message

  before_validation :set_defaults

  validates_presence_of :from_number, :to_number, :body, :sms_message

  def attempt_send
    self.attempted = DateTime.now
    self.save!
    begin
      send_message
      self.successful = true
      self.save
      sms_message.succeeded!
    rescue => e
      # I don't know what exceptions are possible yet
      ErrorLogger.log_error(e)
      sms_message.failed!
    end
  end


  # protected
  def set_defaults
    self.from_number ||= SmsMessageAttempt.from_number
    self.to_number ||= sms_message.user.phone_number
    self.body ||= sms_message.notification.short_message
  end

  def client
    # is the Twilio client threadsafe? who knows these things?
    @client ||= Twilio::REST::Client.new
  end

  def send_message
    client.messages.create(
      to: to_number,
      body: body,
      from: SmsMessageAttempt.from_number 
    )
  end
end
