class WebPageRefreshWorker
  include Sidekiq::Worker
  sidekiq_options queue: :web_page

  def perform(web_page_id)
    web_page = WebPage.find(web_page_id)
    web_page.visit!
    if web_page.page_contents_changed?
      WebPageNotificationWorker.perform_async(web_page.id)
    end
  end
end
