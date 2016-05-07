require 'rails_helper'

RSpec.describe SendSmsWorker do
  describe "#perform" do 
    it "should attempt_send" do 
      attempt = double('attempt')
      expect(SmsMessageAttempt).to receive(:find).with(10).and_return(attempt)
      expect(attempt).to receive(:attempt_send)
      SendSmsWorker.new.perform(10)
    end
  end
end
