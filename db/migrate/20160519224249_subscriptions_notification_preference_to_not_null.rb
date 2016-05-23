class SubscriptionsNotificationPreferenceToNotNull < ActiveRecord::Migration
  def change
    change_column :subscriptions, :notification_preference, :string, null: false
  end
end
