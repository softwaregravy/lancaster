# == Schema Information
#
# Table name: subscriptions
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  subscribable_id   :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subscribable_type :string
#

FactoryGirl.define do
  factory :subscription do
    user
    association :subscribable, factory: :feed
  end
end
