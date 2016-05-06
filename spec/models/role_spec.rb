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
  describe "an empty role" do 
    subject { Role.new }
    before { subject.valid? }
    it { subject.errors.include?(:name).should == true }
  end
  describe "#initialization" do 
    it "should downcase names" do 
      r = Role.create(name: 'ROLE')
      expect(r.name).to eql('role')
    end
  end
end
