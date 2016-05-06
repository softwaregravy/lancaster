class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, null: false
      t.integer :feed_id, null: false

      t.timestamps null: false
    end
    add_index :subscriptions, [:user_id, :feed_id], :unique => true
    add_index :subscriptions, :feed_id
  end
end
