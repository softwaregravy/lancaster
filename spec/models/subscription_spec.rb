# == Schema Information
#
# Table name: subscriptions
#
#  id                      :integer          not null, primary key
#  user_id                 :integer          not null
#  subscribable_id         :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  subscribable_type       :string           not null
#  notification_preference :string           not null
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :subscribable }

  it "has a valid factory" do
    # once we have real tests, we can get rid of this
    create(:subscription).should be_valid
  end

  it "defaults to sms" do 
    sub = create(:subscription, notification_preference: nil)
    sub.notification_preference.should == "sms"
  end

  it "rejects invalid notification types" do
    build(:subscription, notification_preference: "snail mail").should_not be_valid
  end

  describe "#send_notification" do 
    subject {  create :subscription }
    context "when the notification preference is sms" do 
      it "is a sane test" do 
        subject.notification_preference.should == "sms"
      end
      it "creates a new SmsMessage" do 
        notification = create :notification, notification_source: Post.last
        expect {
          subject.send_notification(notification)
        }.to change(SmsMessage, :count).by(1)
      end
      it "exectues send" do 
        notification = create :notification, notification_source: Post.last
        message = double(SmsMessage.new)
        expect(SmsMessage).to receive(:create).and_return(message)
        expect(message).to receive(:execute_send)
        subject.send_notification(notification)
      end
      context "when the user has disabled notifications" do 
        before do
          subject.user.notifications_enabled = false
          subject.user.save!
        end
        it "does nothing" do 
          notification = create :notification, notification_source: Post.last
          expect {
            subject.send_notification(notification)
          }.not_to change(SmsMessage, :count)
        end
      end
      context "when the user is not contactable" do 
        before do
          subject.user.phone_number = nil
          subject.user.save!
        end
        it "does nothing" do 
          notification = create :notification, notification_source: Post.last
          expect {
            subject.send_notification(notification)
          }.not_to change(SmsMessage, :count)
        end
      end
    end
    context "when the notification preference is unrecognized" do 
      it "raises error" do 
        notification = create :notification, notification_source: Post.last
        subject.notification_preference = "not recognized" 
        expect {
          subject.send_notification(notification)
        }.to raise_error(Subscription::UnrecognizedNotificationPreference)
      end
    end
  end
end
