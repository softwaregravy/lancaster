# == Schema Information
#
# Table name: web_page_visits
#
#  id          :integer          not null, primary key
#  web_page_id :integer
#  checksum    :string
#  size        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe WebPageVisit, type: :model do
  it { should validate_presence_of :size }
  it { should validate_presence_of :checksum }

  it "has a working factory" do 
    create :web_page_visit
  end

  describe "#visit" do 
    before do 
      @web_page = create :web_page, url: "http://www.yyzdeals.com"
      stub_request(:get, "http://www.yyzdeals.com/").to_return(:status => 200, :body => "I'm a webpage!")

    end
    it "should create a new web_page_visit" do
      expect {
        WebPageVisit.visit(@web_page)
      }.to change(WebPageVisit, :count).by(1)
    end
    it "should set the page size and digest" do 
      visit = WebPageVisit.visit(@web_page)
      visit.size.should == 14
      visit.checksum.should == "b41af194a7fea4e1c92ea048e6ccbbfa"
    end
  end
end
