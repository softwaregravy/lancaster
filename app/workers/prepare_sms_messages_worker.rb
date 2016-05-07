class PrepareSmsMessagesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :sms

  def perform(post_id)
    post = Post.find(post_id)
    post.feed.subscriptions.find_each do |subscription|
      SmsMessage.create(post: post, user: subscription.user).execute_send
    end
  end
end
