class CreateSmsMessageAttempts < ActiveRecord::Migration
  def change
    create_table :sms_message_attempts do |t|
      t.datetime :attempted
      t.boolean :successful, null: false, default: false
      t.string :to_number, null: false
      t.string :from_number, null: false
      t.string :body, null: false
      t.references :sms_message, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
