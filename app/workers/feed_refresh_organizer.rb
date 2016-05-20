class FeedRefreshOrganizer
  include Sidekiq::Worker
  sidekiq_options queue: :sms

  def perform
    Feed.find_each do |feed|
      FeedRefreshWorker.perform_async(feed.id)
    end
  end
end
