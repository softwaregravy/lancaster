# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  phone_number           :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  describe "valid factories" do
    it { FactoryGirl.create(:user).should be_valid }
    it "should generate a valid amin" do 
      admin = FactoryGirl.create(:admin)
      admin.should be_valid
      admin.role?('admin').should == true
    end
  end

  describe "#role?" do 
    it "should return whether the role is assigned" do 
      r1 = Role.create(name: "ABC")
      r2 = Role.create(name: "XYZ")
      r3 = Role.create(name: "NOT_ASSIGNED")
      user = FactoryGirl.create(:user)
      user.roles = [r1, r2]
      # shouldn't be needed, but lets make sure nothing is cached
      same_user = User.find(user.id)
      same_user.role?("ABC").should == true
      same_user.role?("XYZ").should ==  true
      same_user.role?("NOT_ASSIGNED").should == false
    end
  end

  describe "#admin?" do 
    it { FactoryGirl.create(:user).should_not be_admin }
    it { FactoryGirl.create(:admin).should be_admin }
  end

  describe "#set_default_role" do 
    it "should default to client" do 
      user = FactoryGirl.create(:user)
      user.roles.size.should == 1
      user.role?("client").should == true
    end
  end

  describe "#validate phone number" do 
    it "should be valid without a phone number" do 
      FactoryGirl.build(:user, phone_number: nil).should be_valid
    end
    it "should format valid phone numbers" do 
      ['+12223334444', '5554443333', '(222)555-5555'].each do |phone_number|
        user = FactoryGirl.build(:user, phone_number: phone_number)
        user.should be_valid
        user.phone_number.should == PhoneNumberFormatter.format(phone_number)
      end
    end
    it "should give an error on invalid phone numbers" do 
      ['+122233444', '445554443333', '(2)555-5555'].each do |phone_number|
        user = FactoryGirl.build(:user, phone_number: phone_number)
        user.should_not be_valid
      end
    end
  end
end
