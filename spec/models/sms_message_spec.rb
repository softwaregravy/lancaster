# == Schema Information
#
# Table name: sms_messages
#
#  id             :integer          not null, primary key
#  send_initiated :datetime
#  send_completed :datetime
#  retry_enabled  :boolean          default("true"), not null
#  max_retries    :integer          default("0"), not null
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

  describe "#failed" do 
    context "when max retries is zero" do
      subject { create :sms_message, retry_enabled: true, max_retries: 0 }
      it "should not retry" 
    end
    context "when max retries is 1" do
      subject { create :sms_message, retry_enabled: true, max_retries: 1 }
      it "should retry" 
    end
    context "when max retries is 1, but retry_enabled is false" do
      subject { create :sms_message, retry_enabled: false, max_retries: 1 }
      it "should not retry"
    end
    context "with past failures" do 
      subject { create :sms_message, retry_enabled: true, max_retries: 3 }
      before do 
        3.times { create :sms_message_attempt, sms_message: subject }
      end
      it "should retry"
    end

  end

end
