# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string           not null
#  feed_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :url }
  it { should validate_presence_of :feed }

  it "should have a valid factory" do 
    post = create(:post)
    post.feed.should be_valid
  end

  describe "#fetch_notification" do 
    subject { create :post }
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
        n.short_message.should include(subject.url)
        n.body.should include(subject.url)
        n.subject.should include(subject.title)
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
