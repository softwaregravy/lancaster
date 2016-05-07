class RefreshFeedsWorker
  include Sidekiq::Worker
  sidekiq_options queue: :sms

  def perform
    Feed.find_each do |feed|
      feed.fetch_latest_post(true)
    end
  end
end
