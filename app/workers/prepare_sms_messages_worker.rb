class PrepareSmsMessagesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :sms

  def perform(post_id)
    post = Post.find(post_id)
    post.feed.subscriptions.find_each do |subscription|
      if subscription.user.notifications_enabled? && subscription.user.contactable?
        SmsMessage.create(post: post, user: subscription.user).execute_send
      end
    end
  end
end
