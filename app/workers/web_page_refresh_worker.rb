class WebPageRefreshWorker
  include Sidekiq::Worker
  sidekiq_options queue: :web_page

  def perform(web_page_id)
    web_page = WebPage.find(web_page_id)
    visit = web_page.visit!
    if web_page.page_contents_changed?
      notification = visit.fetch_notification
      NotificationOrganizer.perform_async(notification.id)
    end
  end
end
