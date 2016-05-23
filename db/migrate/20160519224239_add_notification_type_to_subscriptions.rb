class AddNotificationTypeToSubscriptions < ActiveRecord::Migration
  class Subscription < ActiveRecord::Base
  end
  def up
    add_column :subscriptions, :notification_preference, :string
    Subscription.update_all(notification_preference: "sms")
  end

  def down
    remove_column :subscriptions, :notification_preference
  end
end
