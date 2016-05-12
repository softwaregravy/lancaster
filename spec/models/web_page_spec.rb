# == Schema Information
#
# Table name: web_pages
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe WebPage, type: :model do
  it { should validate_presence_of :url }
  it "has a working factory" do
    create :web_page
  end
end
