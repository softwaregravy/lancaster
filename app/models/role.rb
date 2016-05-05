# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  before_validation :downcase_name
  validates_presence_of :name

  def downcase_name
    self.name = name.downcase if name.present?
  end
end
