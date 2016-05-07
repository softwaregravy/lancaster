require 'rails_helper'

RSpec.describe PrepareSmsMessagesWorker do 
  describe "#perform" do 
    before do
      @post = create :post
      @post.feed.subscriptions.create user: create(:user)
    end
    it "should create a message per subscriber" do 
      @post.feed.subscriptions.create user: create(:user)
      expect {
        subject.perform(@post.id)
      }.to change(SmsMessage, :count).by(2)
    end
    it "should send the messages" do 
      expect_any_instance_of(SmsMessage).to receive(:execute_send)
      subject.perform(@post.id)
    end
  end
end
