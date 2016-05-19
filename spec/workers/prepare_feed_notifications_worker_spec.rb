require 'rails_helper'

RSpec.describe PrepareFeedNotificationsWorker do 
  describe "#perform" do 
    context "when the user allows notifications" do 
      before do
        @post = create :post
        @post.feed.subscriptions.create user: create(:user, notifications_enabled: true)
      end
      it "should create a message per subscriber" do 
        @post.feed.subscriptions.create user: create(:user, notifications_enabled: true)
        expect {
          subject.perform(@post.id)
        }.to change(SmsMessage, :count).by(2)
      end
      it "should send the messages" do 
        expect_any_instance_of(SmsMessage).to receive(:execute_send)
        subject.perform(@post.id)
      end
    end
    context "when the user disables notifications" do 
      before do
        @post = create :post
        @post.feed.subscriptions.create user: create(:user, notifications_enabled: false)
      end
      it "should not create messages" do 
        @post.feed.subscriptions.create user: create(:user, notifications_enabled: false)
        expect {
          subject.perform(@post.id)
        }.not_to change(SmsMessage, :count)
      end
      it "should not send the messages" do 
        expect_any_instance_of(SmsMessage).not_to receive(:execute_send)
        subject.perform(@post.id)
      end
    end
    context "when the user is not contactable" do 
      before do
        @post = create :post
        @post.feed.subscriptions.create user: create(:user, notifications_enabled: true, phone_number: nil)
      end
      it "should not create messages" do 
        @post.feed.subscriptions.create user: create(:user, notifications_enabled: true, phone_number: nil)
        expect {
          subject.perform(@post.id)
        }.not_to change(SmsMessage, :count)
      end
      it "should not send the messages" do 
        expect_any_instance_of(SmsMessage).not_to receive(:execute_send)
        subject.perform(@post.id)
      end
    end
  end
end
