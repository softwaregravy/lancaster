class SmsMessage
  class << self
    attr_accessor :from_number
  end

  include ActiveModel::Validations

  attr_accessor :to, :body

  validates_presence_of :to, :body
  # 10 digits plus leading +1 "+13213213210"
  validates_format_of :to, with: PhoneNumberFormatter.valid_format

  def initialize(attr = {})
    self.to= attr[:to]
    @body = attr[:body]
  end

  def to=(phone_number)
    @to = PhoneNumberFormatter.format(phone_number)
  end

  def persisted?
    false
  end
  
  def client
    # is the Twilio client threadsafe? who knows these things?
    @client ||= Twilio::REST::Client.new
  end

  def send
    client.messages.create(
      to: to,
      body: body,
      from: SmsMessage.from_number 
    )
  end

end
