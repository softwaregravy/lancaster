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

require 'rails_helper'

RSpec.describe SmsMessageAttempt, type: :model do
  it "should have a valid factory" do
    attempt = create :sms_message_attempt
    attempt.sms_message.should be_valid
    attempt.sms_message.user.should be_valid
    attempt.sms_message.post.should be_valid
  end

  describe "#set_defaults" do 
    subject { create :sms_message_attempt, to_number: nil, from_number: nil, body: nil }
    it "should use the default from phone number" do 
      subject.from_number.should == SmsMessageAttempt.from_number
    end 
    it "should pull the to_number from the user" do 
      subject.to_number.should == subject.sms_message.user.phone_number
    end
    it "should use the default body" do 
      subject.body.should be_include(subject.sms_message.post.url)
    end
  end

  describe "#attempt_send" do 
    before do 
      number = "+15555555555"
      body = "message"
      twilio = double(:twilio)
      expect(Twilio::REST::Client).to receive(:new).and_return(twilio)
      messages = double(:twilio_messages)
      expect(twilio).to receive(:messages).and_return(messages)
      expect(messages).to receive(:create).with({to: number, body: body, from: SmsMessageAttempt.from_number})

      @sms = create(:sms_message_attempt, to_number: number, body: body)
    end
    it "should send the message" do 
      # relies on the expectations in the before to pass
      @sms.attempt_send
    end
    it "should record attempted timestamp" do 
      @sms.attempted.should == nil
      @sms.attempt_send
      @sms.attempted.should_not == nil
    end
  end
end
