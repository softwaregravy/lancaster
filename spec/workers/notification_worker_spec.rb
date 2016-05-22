require 'rails_helper'

RSpec.describe NotificationWorker do 
  before do 
    @not = create :notification
    @sub = create :subscription, subscribable: @not.notification_source.subscribable
  end
  it "sends the notification" do
    expect(Subscription).to receive(:find).with(@sub.id).and_return(@sub)
    expect(@sub).to receive(:send_notification).with(@not)
    NotificationWorker.new.perform(@sub.id, @not.id)
  end
end
