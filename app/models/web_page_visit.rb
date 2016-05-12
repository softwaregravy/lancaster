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

class WebPageVisit < ActiveRecord::Base
  belongs_to :web_page
end
