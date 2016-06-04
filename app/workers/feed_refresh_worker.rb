class FeedRefreshWorker
  include Sidekiq::Worker
  sidekiq_options queue: :sms

  def perform(feed_id)
    post = Feed.find(feed_id).fetch_latest_post
    if post.present?
      notification = post.fetch_notification
      NotificationOrganizer.perform_async(notification.id)
    end
  end
end
