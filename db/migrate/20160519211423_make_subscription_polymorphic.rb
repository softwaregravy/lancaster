class MakeSubscriptionPolymorphic < ActiveRecord::Migration
  class Subscription < ActiveRecord::Base
  end
  def up
    remove_index :subscriptions, [:user_id, :feed_id]
    rename_column :subscriptions, :feed_id, :subscribable_id
    add_column :subscriptions, :subscribable_type, :string
    Subscription.update_all(subscribable_type: Feed.to_s)
  end

  def down
    rename_column :subscriptions, :subscribable_id, :feed_id
    remove_column :subscriptions, :subscribable_type
    add_index :subscriptions, [:user_id, :feed_id], :unique => true
  end

end
