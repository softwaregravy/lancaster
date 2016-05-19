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

FactoryGirl.define do
  factory :subscription do
    user
    association :subscribable, factory: :feed
    notification_preference "sms"
  end
end
