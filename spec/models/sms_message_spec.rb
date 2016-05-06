require 'rails_helper'

RSpec.describe SmsMessage do 

  subject{ build(:sms_message) }

  describe "#persisted?" do 
    it "should be false" do 
      expect(subject.persisted?).to be false
    end 
  end

  describe "#initialize" do 
    it "should set body" do 
      attr = attributes_for(:sms_message)
      message = SmsMessage.new(attr)
      message.body.should eql(attr[:body])
    end
    it "should set and format the to number" do 
      attr = attributes_for(:sms_message)
      message = SmsMessage.new(attr)
      message.to.should eql(PhoneNumberFormatter.format(attr[:to]))
    end
  end

  describe "#to=" do 
    before do 
      # subject is created lazy, force it to exist before test
      subject.persisted?
    end
    it "should format and assign the phone number" do 
      seed_number = "+15555555555"
      expect(PhoneNumberFormatter).to receive(:format).and_return(seed_number)
      subject.to = "1231231234"
      expect(subject.to).to eql(seed_number)
    end
  end

  describe "#send" do 
    it "should send the message" do 
      number = "+15555555555"
      body = "message"
      twilio = double(:twilio)
      expect(Twilio::REST::Client).to receive(:new).and_return(twilio)
      messages = double(:twilio_messages)
      expect(twilio).to receive(:messages).and_return(messages)
      expect(messages).to receive(:create).with({to: number, body: body, from: SmsMessage.from_number})

      sms = SmsMessage.new({to: number, body: body})
      sms.send
    end
  end

end
