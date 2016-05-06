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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_and_belongs_to_many :roles
  has_many :subscriptions

  before_validation :set_default_role
  validate :validate_and_format_phone_number

  def role?(role = "")
    roles.where(name: role.to_s.downcase).take.present?
  end

  def admin?
    role? 'admin'
  end

  def set_default_role
    roles << Role.where(name: "client").take unless role? :client
  end

  def validate_and_format_phone_number
    if phone_number.present?
      formatted_number = PhoneNumberFormatter.format(phone_number)
      if formatted_number.present?
        self.phone_number = formatted_number
      else
        errors[:phone_number] << "unable to parse phone number"
      end
    end
  end
end
