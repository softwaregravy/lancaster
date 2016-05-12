

RSpec.configure do |config|
  config.before(:each) do
    @feed_data = File.read(Rails.root.join('spec', 'fixtures', 'yyz_deals_feed.xml'))
    @feed_url = "http://example.com/yyy_deals"
    @feed_stub = stub_request(:any, @feed_url).to_return(body: @feed_data)
  end
end
