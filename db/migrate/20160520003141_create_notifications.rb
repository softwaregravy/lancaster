class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :subject
      t.string :body
      t.string :short_message
      t.references :notification_source, polymorphic: true, index: { name: 'index_notifications_notifications_source' }

      t.timestamps null: false
    end
  end
end
