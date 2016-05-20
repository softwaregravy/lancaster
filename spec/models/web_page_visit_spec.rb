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

  describe "#fetch_notification" do 
    subject { create :web_page_visit }
    context "when no notification exists" do 
      it "creates a new notification" do 
        expect {
          subject.fetch_notification
        }.to change(Notification, :count).by(1)
      end
      it "uses good parms for the notification" do 
        subject.fetch_notification 
        n = Notification.last
        n.notification_source.should == subject
        n.short_message.should include(subject.web_page.url)
        n.body.should include(subject.web_page.url)
        n.subject.should include(subject.web_page.display_name)
      end
    end
    context "when it already has a notification" do
      before { subject.fetch_notification }
      it "does not create a new notification" do
        expect {
          subject.fetch_notification
        }.not_to change(Notification, :count)
      end
    end
  end
end
