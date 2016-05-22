require 'rails_helper'

RSpec.describe NotificationOrganizer do
  before do 
    @post = create :post
    @notification = create :notification, notification_source: @post
    @subscription1 = create :subscription, subscribable: @post.feed
    @subscription2 = create :subscription, subscribable: @post.feed
  end
  it "notifies each subscription" do 
    expect(NotificationWorker).to receive(:perform_async).with(@subscription1.id, @notification.id)
    expect(NotificationWorker).to receive(:perform_async).with(@subscription2.id, @notification.id)
    NotificationOrganizer.new.perform(@notification.id)
  end
end
