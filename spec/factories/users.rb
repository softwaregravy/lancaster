# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  email        :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do 
  factory :user do 
    sequence :email do |n| "email#{n}@example.com" end
    phone_number "555-555-5555"
  end
end
