require "config/boot"
require "config/environment"
require 'clockwork'

module Clockwork
  every 1.hour, 'refreshing_feeds' do
    RefreshFeedsWorker.perform_async
  end
end
