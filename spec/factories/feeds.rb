# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

FactoryGirl.define do
  factory :feed do
    name { Faker::Superhero.name }
    url "http://example.com/yyy_deals"
  end
  factory :random_feed, class: Feed do
    name { Faker::Superhero.name }
    url { Faker::Internet.url }
  end
end
