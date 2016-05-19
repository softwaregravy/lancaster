class AddNotificationTypeToSubscriptions < ActiveRecord::Migration
  class Subscription < ActiveRecord::Base
  end
  def up
    add_column :subscriptions, :notification_preference, :string
    Subscription.find_each do |s|
      s.notification_preference = "sms"
      s.save!
    end
    change_column :subscriptions, :notification_preference, :string, null: false
  end

  def down
    remove_column :subscriptions, :notification_preference
  end
end
