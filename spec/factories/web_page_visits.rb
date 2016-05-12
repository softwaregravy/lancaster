# == Schema Information
#
# Table name: web_page_visits
#
#  id          :integer          not null, primary key
#  web_page_id :integer
#  checksum    :string
#  size        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :web_page_visit do
    web_page 
    checksum "12345"
    size 12345
  end
end
