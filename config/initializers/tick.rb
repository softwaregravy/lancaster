require 'tickwork'

module Tickwork
  configure do |config|
    config[:data_store] = AwsTickwork::DbDataStore
    config[:tick_size] = 60 # 1 minute                                                                                                                                                                                                                                                                                                                                         
    config[:max_ticks] = ENV['TICKWORK_MAX_TICKS'] || 10 
  end
  every 1.hour, 'refreshing_feeds' do
    RefreshFeedsWorker.perform_async
  end
end
