# == Schema Information
#
# Table name: web_pages
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :web_page do
    url { Faker::Internet.url }
  end
end
