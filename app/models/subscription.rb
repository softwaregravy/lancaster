# == Schema Information
#
# Table name: subscriptions
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  subscribable_id   :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subscribable_type :string
#

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  validates_presence_of :user, :subscribable
end
