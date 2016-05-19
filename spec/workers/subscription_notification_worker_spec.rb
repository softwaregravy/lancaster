require 'rails_helper'

RSpec.describe SubscriptionNotificationWorker do 
  describe "#peform" do 
    before do 
      @feed = create :feed
      @user = create :user
      @sub = @user.subscriptions.create!(subscribable: @feed)
    end
    it "sends the notifications" do 
      expect_any_instance_of(Subscription).to receive(:send_notification!)
      subject.perform(@sub.id)
    end
  end
end
