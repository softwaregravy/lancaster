class RenamePostIdToNotificationIdInSmsMessages < ActiveRecord::Migration
  class SmsMessage < ActiveRecord::Base
  end
  def up
    SmsMessageAttempt.delete_all
    SmsMessage.delete_all
    remove_column :sms_messages, :post_id
    add_column :sms_messages, :notification_id, :integer
  end

  def down
    SmsMessageAttempt.delete_all
    SmsMessage.delete_all
    remove_column :sms_messages, :notification_id
    add_column :sms_messages, :post_id, :integer
  end
end
