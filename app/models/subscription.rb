# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  feed_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  validates_presence_of :user, :feed
end
