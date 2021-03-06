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
#  notifications_enabled  :boolean          default("false"), not null
#

FactoryGirl.define do 
  factory :user do 
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    notifications_enabled true
    # don't use phone_number -- it has extensions
    phone_number { Faker::PhoneNumber.cell_phone }
    factory :admin do 
      after(:create) do |user, evaluator|
        admin_role = Role.where(name: "admin").take
        user.roles = [admin_role]
      end
    end
  end
end
