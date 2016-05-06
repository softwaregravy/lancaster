# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should validate_presence_of :name }

  describe "#initialization" do 
    it "should downcase names" do 
      r = Role.create(name: 'ROLE')
      expect(r.name).to eql('role')
    end
  end
end
