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
      # https://github.com/lostisland/faraday#using-faraday-for-testing
      stub_request(:any, "http://example.com/yyy_deals").to_return(body: @feed_data)
    end
    describe "#latest_title_and_link" do 
      it "should return latest title and link" do 
        feed = create(:feed, url: "http://example.com/yyy_deals")
        feed.latest_title_and_link.should == [
          "Toronto to Osaka / Kyoto, Japan - $565 CAD roundtrip including taxes",
          "http://yyzdeals.com/toronto-to-osaka-kyoto-japan-565-cad-roundtrip-including-taxes"
        ]
      end
    end

  end
end
