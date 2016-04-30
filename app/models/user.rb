# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  email        :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class User < ActiveRecord::Base
end
