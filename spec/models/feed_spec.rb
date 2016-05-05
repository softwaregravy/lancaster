# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Feed, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :url }
  describe "#initialize" do 
    it "should initialize correctly" do 
      # no logic yet, just sanity test the class
      FactoryGirl.create(:feed)
    end
  end
end
