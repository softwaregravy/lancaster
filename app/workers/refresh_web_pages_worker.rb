class RefreshWebPagesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :web_page

  def perform
    WebPage.find_each do |web_page|
      web_page.visit!
    end
  end

end
