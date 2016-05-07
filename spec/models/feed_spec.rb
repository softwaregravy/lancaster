# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Feed, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :url }

  describe "#initialize" do 
    it "should initialize correctly" do 
      # no logic yet, just sanity test the class
      create(:feed)
    end
  end

  describe "getting feed data" do 
    before do 
      @feed_data = File.read(Rails.root.join('spec', 'fixtures', 'yyz_deals_feed.xml'))
      @feed_url = "http://example.com/yyy_deals"
      stub_request(:any, @feed_url).to_return(body: @feed_data)
    end
    describe "#latest_title_and_link" do 
      it "should return latest title and link" do 
        feed = create(:feed, url: @feed_url)
        feed.latest_title_and_link.should == [
          "Toronto to Osaka / Kyoto, Japan - $565 CAD roundtrip including taxes",
          "http://yyzdeals.com/toronto-to-osaka-kyoto-japan-565-cad-roundtrip-including-taxes"
        ]
      end
    end
    describe "#fetch_latest_post" do 
      it "should return the post" do 
        feed = create(:feed, url: @feed_url)
        feed.fetch_latest_post.should be_a(Post)
      end
      it "should save the post to the database" do 
        feed = create(:feed, url: @feed_url)
        expect {
          feed.fetch_latest_post.should be_a(Post)
        }.to change(Post, :count).by(1)
      end
      it "should have the correct data" do 
        feed = create(:feed, url: @feed_url)
        post = feed.fetch_latest_post
        post.title.should == "Toronto to Osaka / Kyoto, Japan - $565 CAD roundtrip including taxes"
        post.url.should == "http://yyzdeals.com/toronto-to-osaka-kyoto-japan-565-cad-roundtrip-including-taxes"
      end
      it "should not create duplicates" do 
        feed = create(:feed, url: @feed_url)
        feed.fetch_latest_post.should be_a(Post)
        expect {
          feed.fetch_latest_post.should be_a(Post)
        }.to_not change(Post, :count)
      end
      it "should notify subscribers" do 
        feed = create(:feed, url: @feed_url)
        expect(PrepareSmsMessagesWorker).to receive(:perform_async)
        feed.fetch_latest_post(true)
      end
    end

  end
end
