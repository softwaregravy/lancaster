source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'
# Use postgresql as the database for Active Record
gem 'pg'

# WEB Gems
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0' # Use CoffeeScript for .coffee assets and views
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'turbolinks' # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

# DOCUMENTATION
gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.

# Use Puma as the app server
gem 'puma'
gem 'rack-timeout'

# authentication & authorization
gem 'devise'
gem 'cancancan', '~> 3.0'

# Twilio :)
gem 'twilio-ruby', '~> 4.11.1'

# Reading RSS
gem 'feedjira'
gem 'addressable' # url validation
gem 'dalli' # cache 

# Debugging and Tools
gem 'awesome_print' # cause I'm a prima donna

gem 'sidekiq'
gem 'sinatra', :require => nil
gem 'aws_tickwork'

# Error Tracking
gem 'rollbar'

gem 'quiet_assets'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'webmock'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'annotate'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end

group :test do
  gem 'simplecov'
  gem 'codeclimate-test-reporter'
  gem 'shoulda-matchers', require: false
end

group :production do 
  gem 'rails_12factor'
end

ruby "2.3.1"
