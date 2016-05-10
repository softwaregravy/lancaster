require 'tickwork'

module Tickwork
  configure do |config|
    config[:data_store] = AwsTickwork::DbDataStore
  end
  every 1.hour, 'refreshing_feeds' do
    RefreshFeedsWorker.perform_async
  end
end
