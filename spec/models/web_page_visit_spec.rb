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

require 'rails_helper'

RSpec.describe WebPageVisit, type: :model do
  it "has a working factory" do 
    create :web_page_visit
  end
end
