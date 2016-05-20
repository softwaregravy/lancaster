# == Schema Information
#
# Table name: web_pages
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe WebPage, type: :model do
  it { should validate_presence_of :url }
  it "has a working factory" do
    create :web_page
  end

  describe "#visit!" do 
    before do 
      @web_page = create :web_page, url: "http://www.yyzdeals.com"
      stub_request(:get, "http://www.yyzdeals.com/").to_return(:status => 200, :body => "I'm a webpage!")
    end
    it "should create a new web_page_visit" do
      expect {
        @web_page.visit!
      }.to change(WebPageVisit, :count).by(1)
    end
    it "should set the page size and digest" do 
      visit = @web_page.visit!
      visit.size.should == 14
      visit.checksum.should == "b41af194a7fea4e1c92ea048e6ccbbfa"
    end
    describe "#visit" do 
      it "does not create a web page visit" do
        expect {
          @web_page.visit
        }.not_to change(WebPageVisit, :count)
      end
    end
  end

  describe "#page_contents_changed?" do 
    subject { create :web_page }
    it "is a sane test" do 
      # just to verify our factory never creates visits
      subject.web_page_visits.count.should == 0
    end
    context "with no visits" do 
      it "returns false" do 
        subject.page_contents_changed?.should == false
      end
    end
    context "with 1 visit" do 
      before { create :web_page_visit, web_page: subject }
      it "returns false" do 
        subject.page_contents_changed?.should == false
      end
    end
    context "with >1 visit and the same checksums" do 
      before do 
        create :web_page_visit, web_page: subject, size: 1, checksum: "x"
        create :web_page_visit, web_page: subject, size: 1, checksum: "x"
      end
      it "returns false" do 
        subject.page_contents_changed?.should == false
      end
    end
    context "with >1 visit and different checksums" do 
      before do 
        # use 3 to verify we're checking the last 2
        create :web_page_visit, web_page: subject, size: 1, checksum: "x"
        create :web_page_visit, web_page: subject, size: 1, checksum: "x"
        create :web_page_visit, web_page: subject, size: 1, checksum: "y"
      end
      it "returns true" do
        subject.page_contents_changed?.should == true
      end
    end
  end
end
