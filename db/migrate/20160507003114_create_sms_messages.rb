class CreateSmsMessages < ActiveRecord::Migration
  def change
    create_table :sms_messages do |t|
      t.datetime :send_initiated
      t.datetime :send_completed
      t.boolean :retry_enabled, null: false, default: true
      t.integer :max_attempts, null: false, default: 1
      t.references :user, index: true, foreign_key: true, null: false
      t.references :post, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
