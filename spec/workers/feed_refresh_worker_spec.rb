require 'rails_helper'

RSpec.describe FeedRefreshWorker do 
  before do 
    @feed = create :feed
  end
  it "refreshes the feed" do 
    expect_any_instance_of(Feed).to receive(:fetch_latest_post)
    FeedRefreshWorker.new.perform(@feed.id)
  end
  context "when a new post is found" do
    before do 
      @post = create :post, feed: @feed
      allow_any_instance_of(Feed).to receive(:fetch_latest_post).and_return(@post)
    end
    it "creates a notification" do
      expect {
        FeedRefreshWorker.new.perform(@feed.id)
      }.to change(Notification, :count).by(1)
    end
    it "sends notifications" do
      NotificationOrganizer.should_receive(:perform_async)
      FeedRefreshWorker.new.perform(@feed.id)
    end 
  end
  context "when a new post is not found" do 
    before do 
      allow_any_instance_of(Feed).to receive(:fetch_latest_post).and_return(nil)
    end
    it "does not sends notifications" do
      NotificationOrganizer.should_not_receive(:perform_async)
      FeedRefreshWorker.new.perform(@feed.id)
    end
  end

end
