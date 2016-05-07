# == Schema Information
#
# Table name: sms_messages
#
#  id             :integer          not null, primary key
#  send_initiated :datetime
#  send_completed :datetime
#  retry_enabled  :boolean          default("true"), not null
#  max_attempts   :integer          default("1"), not null
#  user_id        :integer          not null
#  post_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe SmsMessage, type: :model do
  it "should have a valid factory" do 
    message = create :sms_message
    message.user.should be_valid
    message.post.should be_valid
  end
  describe "#record_start_time" do 
    subject { create :sms_message }
    it "should record start time" do 
      subject.send_initiated.should == nil
      subject.record_start_time
      subject.send_initiated.should_not == nil
    end
  end
  describe "#succeeded" do 
    subject { create :sms_message }
    it "should record the completion time" do 
      subject.send_completed.should == nil
      subject.succeeded!
      subject.send_completed.should_not == nil
    end
  end
  describe "#queue_attempt" do 
    subject { create :sms_message }
    it "should create an sms message attempt" do 
      expect{subject.queue_attempt}.to change(SmsMessageAttempt, :count).by 1
    end
    it "should pass the id to the job" do 
      attempt = double(SmsMessageAttempt.new, id: 10)
      expect(SmsMessageAttempt).to receive(:create).and_return(attempt)
      expect(SendSmsWorker).to receive(:perform_async).with(10)
      subject.queue_attempt
    end
  end

  describe "#failed" do 
    context "when max attempts is zero" do
      subject { create :sms_message, retry_enabled: true, max_attempts: 0 }
      it "should not retry" do
        expect(subject).not_to receive(:queue_attempt)
        subject.failed!
      end
    end
    context "when max attempts is 1" do
      subject { create :sms_message, retry_enabled: true, max_attempts: 1 }
      it "should retry" do
        expect(subject).to receive(:queue_attempt)
        subject.failed!
      end
    end
    context "when max attempts is 1, but retry_enabled is false" do
      subject { create :sms_message, retry_enabled: false, max_attempts: 1 }
      it "should not retry" do 
        expect(subject).not_to receive(:queue_attempt)
        subject.failed!
      end
    end
    context "with past failures" do 
      subject { create :sms_message, retry_enabled: true, max_attempts: 3 }
      before do 
        2.times { create :sms_message_attempt, sms_message: subject }
      end
      it "should retry" do 
        expect(subject).to receive(:queue_attempt)
        subject.failed!
      end
    end

  end

end
