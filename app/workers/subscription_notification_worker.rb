class SubscriptionNotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: :notifications

  def perform(subscription_id)
    sub = Subscription.find(subscription_id)
    sub.send_notification!
  end
end
