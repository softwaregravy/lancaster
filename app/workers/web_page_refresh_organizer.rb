class WebPageRefreshOrganizer
  include Sidekiq::Worker
  sidekiq_options queue: :web_page

  def perform
    WebPage.find_each do |web_page|
      Resque.enqueue(WebPageRefreshWorker, web_page.id)
    end
  end
end
