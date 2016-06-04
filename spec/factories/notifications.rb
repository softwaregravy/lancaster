# == Schema Information
#
# Table name: notifications
#
#  id                       :integer          not null, primary key
#  subject                  :string
#  body                     :string
#  short_message            :string
#  notification_source_id   :integer
#  notification_source_type :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

FactoryGirl.define do
  factory :notification do
    subject "I'm a notification"
    body "I contain notification details"
    short_message "short details"
    association :notification_source, factory: :post
  end
end
