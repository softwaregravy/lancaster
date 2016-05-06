# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  feed_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "an empty role" do 
    subject { Subscription.new }
    before { subject.valid? }
    it { subject.errors.include?(:user).should == true }
    it { subject.errors.include?(:feed).should == true }
  end
  it "should have a valid factory" do
    # once we have real tests, we can get rid of this
    FactoryGirl.create(:subscription).should be_valid
  end
end
