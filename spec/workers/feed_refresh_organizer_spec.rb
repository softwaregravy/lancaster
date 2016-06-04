require 'rails_helper'

RSpec.describe FeedRefreshOrganizer do
  describe "#perform" do 
    before do
      #TODO get the factory working with random URLs
      url1 = Faker::Internet.url
      stub_request(:get, url1).to_return(:status => 200, :body => @feed_data)
      @feed1 = create :feed, url: url1
      url2 = Faker::Internet.url
      stub_request(:get, url2).to_return(:status => 200, :body => @feed_data)
      @feed2 = create :feed, url: url2
    end
    it "schedule feed refresh workers" do
      expect(FeedRefreshWorker).to receive(:perform_async).with(@feed1.id)
      expect(FeedRefreshWorker).to receive(:perform_async).with(@feed2.id)
      FeedRefreshOrganizer.new.perform
    end
  end
end
