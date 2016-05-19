# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

require 'rails_helper'

RSpec.describe Feed, type: :model do
  it { should validate_presence_of :url }

  describe "#display_name" do 
    context "when populated" do
      subject { build(:feed, name: "howdy ho", title: "south park") }
      it "works as normal" do 
        subject.display_name.should == "howdy ho"
      end
    end
    context "when nil" do
      subject { build(:feed, name: nil, title: "south park") }
      it "defaults to title" do
        subject.display_name.should == "south park"
      end
    end
  end

    describe "#verify_feed" do 
      it "sets the feed title" do 
        feed = create :feed
        feed.verify_feed
        feed.title.should == "YYZ Deals :: Toronto Flight Deals and All Inclusive Specials"
      end
      it "verifies feed on create" do 
        expect_any_instance_of(Feed).to receive(:verify_feed)
        create(:feed)
      end
      it "verfieis feed if url changes" do 
        feed = create(:feed)
        expect(feed).to receive(:verify_feed)
        feed.url = "https://www.facebook.com"
        feed.save
      end
      it "does not verify feed if the url does not change" do 
        feed = create(:feed)
        expect(feed).not_to receive(:verify_feed)
        feed.name = "Facebook"
        feed.save
      end
      context "when no title is found" do 
        before do 
          remove_request_stub(@feed_stub)
          feed_data_no_title = File.read(Rails.root.join('spec', 'fixtures', 'yyz_deals_feed_no_title.xml'))
          feed_url = "http://example.com/yyy_deals"
          stub_request(:any, feed_url).to_return(body: feed_data_no_title)
        end
        it "falls back to the domain" do 
          feed = create(:feed)
          feed.title.should == "example.com"
        end
      end
    end
  describe "getting feed data" do 
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
        expect(PrepareFeedNotificationsWorker).to receive(:perform_async)
        feed.fetch_latest_post(true)
      end
    end

  end
end
