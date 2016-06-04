require 'rails_helper'

RSpec.describe WebPageRefreshWorker do 
  before do 
    @web_page = create :web_page
    expect(WebPage).to receive(:find).with(@web_page.id).and_return(@web_page)
  end
  it "visits the web page" do 
    @web_page.should_receive(:visit!)
    WebPageRefreshWorker.new.perform(@web_page.id)
  end
  context "when the contents" do 
    before do
      @notification = create :notification
      @visit = double('visit')
      allow(@visit).to receive(:fetch_notification).and_return(@notification)
      allow(@web_page).to receive(:visit!).and_return(@visit)
    end
    context "have changed" do
      before do 
        expect(@web_page).to receive(:page_contents_changed?).and_return(true)
      end
      it "queues a notification organizer" do 
        expect(NotificationOrganizer).to receive(:perform_async).with(@notification.id)
        WebPageRefreshWorker.new.perform(@web_page.id)
      end
    end
    context "have not changed" do
      before do 
        expect(@web_page).to receive(:page_contents_changed?).and_return(false)
      end
      it "does nothing else" do 
        expect(NotificationOrganizer).not_to receive(:perform_async)
        WebPageRefreshWorker.new.perform(@web_page.id)
      end
    end
  end
end
