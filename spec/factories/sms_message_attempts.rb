# == Schema Information
#
# Table name: sms_message_attempts
#
#  id             :integer          not null, primary key
#  attempted      :datetime
#  successful     :boolean          default("false"), not null
#  to_number      :string           not null
#  from_number    :string           not null
#  body           :string           not null
#  sms_message_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :sms_message_attempt do
    attempted nil
    successful false
    to_number { PhoneNumberFormatter.format(Faker::PhoneNumber.cell_phone) }
    from_number nil
    body { Faker::Lorem.words(10) }
    sms_message 
  end
end
