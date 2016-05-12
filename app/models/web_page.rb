# == Schema Information
#
# Table name: web_pages
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WebPage < ActiveRecord::Base
  has_many :web_page_visits

  validates :url, uri: true, presence: true
end
