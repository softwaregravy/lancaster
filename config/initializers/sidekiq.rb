
require 'sidekiq'

# http://manuelvanrijn.nl/blog/2012/11/13/sidekiq-on-heroku-with-redistogo-nano/
# https://github.com/mperham/sidekiq/issues/298
# max connections = (Heroku worker count * (concurrency + 2 reserved connections)) + 
#           (web dyno count * (client connection size * unicorn worker_process size))

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 5 }
end
