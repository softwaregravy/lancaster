# == Schema Information
#
# Table name: subscriptions
#
#  id                      :integer          not null, primary key
#  user_id                 :integer          not null
#  subscribable_id         :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  subscribable_type       :string           not null
#  notification_preference :string           not null
#

class Subscription < ActiveRecord::Base
  before_validation :default_notification_preference
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  validates_presence_of :user, :subscribable, :notification_preference
  NOTIFICATION_OPTIONS = %w{sms}
  validates :notification_preference, inclusion: { in: NOTIFICATION_OPTIONS }

  def send_notification!
  end

  def default_notification_preference
    self.notification_preference ||= "sms"
  end

end
