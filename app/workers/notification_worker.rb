class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: :notifications

  def perform(subscription_id, notification_id)
    sub = Subscription.find(subscription_id)
    notification = Notification.find(notification_id)
    sub.send_notification(notification)
  end
end
