# == Schema Information
#
# Table name: subscriptions
#
#  id                      :integer          not null, primary key
#  user_id                 :integer          not null
#  subscribable_id         :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  subscribable_type       :string           not null
#  notification_preference :string           not null
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :subscribable }

  it "has a valid factory" do
    # once we have real tests, we can get rid of this
    create(:subscription).should be_valid
  end

  it "defaults to sms" do 
    sub = create(:subscription, notification_preference: nil)
    sub.notification_preference.should == "sms"
  end

  it "rejects invalid notification types" do
    build(:subscription, notification_preference: "snail mail").should_not be_valid
  end
end
