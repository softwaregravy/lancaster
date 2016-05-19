class WebPageNotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: :web_page

  def perform(web_page_id)
    web_page = WebPage.find(web_page_id)
  end
end
