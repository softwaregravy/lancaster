class NotificationOrganizer
  include Sidekiq::Worker
  sidekiq_options queue: :sms

  def perform(notification_id)
    notification = Notification.find(notification_id)
    notification.subscribable.subscriptions.find_each do |sub|
      NotificationWorker.perform_async(sub.id, notification_id)
    end
  end
end

