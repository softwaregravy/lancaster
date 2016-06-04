require 'rails_helper'

RSpec.describe WebPageRefreshOrganizer do 
  describe "#perform" do 
    before do 
      @wb1 = create :web_page
      @wb2 = create :web_page
    end
    it "shedules web page refresh workers" do 
      expect(WebPageRefreshWorker).to receive(:perform_async).with(@wb1.id)
      expect(WebPageRefreshWorker).to receive(:perform_async).with(@wb2.id)
      WebPageRefreshOrganizer.new.perform
    end
  end
end
