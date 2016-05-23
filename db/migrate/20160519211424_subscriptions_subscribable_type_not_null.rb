class SubscriptionsSubscribableTypeNotNull < ActiveRecord::Migration
  def change
    change_column :subscriptions, :subscribable_type, :string, null: false
    add_index :subscriptions, [:user_id, :subscribable_id, :subscribable_type], :unique => true, :name => "unique_user_subscriptions"
  end
end
