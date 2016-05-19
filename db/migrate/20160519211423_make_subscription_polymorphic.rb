class MakeSubscriptionPolymorphic < ActiveRecord::Migration
  class Subscription < ActiveRecord::Base
  end
  def up
    remove_index :subscriptions, [:user_id, :feed_id]
    rename_column :subscriptions, :feed_id, :subscribable_id
    add_column :subscriptions, :subscribable_type, :string
    Subscription.find_each do |s|
      s.subscribable_type = Feed.to_s
      s.save!
    end
    add_index :subscriptions, [:user_id, :subscribable_id, :subscribable_type], :unique => true, :name => "unique_user_subscriptions"
    change_column :subscriptions, :subscribable_type, :string, null: false
  end

  def down
    rename_column :subscriptions, :subscribable_id, :feed_id
    remove_column :subscriptions, :subscribable_type
    add_index :subscriptions, [:user_id, :feed_id], :unique => true
  end

end
