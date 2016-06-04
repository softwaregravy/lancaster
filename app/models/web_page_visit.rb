# == Schema Information
#
# Table name: web_page_visits
#
#  id          :integer          not null, primary key
#  web_page_id :integer
#  checksum    :string
#  size        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'open-uri'

class WebPageVisit < ActiveRecord::Base
  belongs_to :web_page
  has_one :notification, as: :notification_source
  validates_presence_of :checksum, :size

  def fetch_notification
    if self.notification.nil?
      create_notification(params_for_notification)
    end
    self.notification
  end

  def params_for_notification
    {
      short_message: "Webpage updated: #{web_page.url}",
      subject: "Webpage updated: #{web_page.display_name}",
      body: "Change detected on web page: #{web_page.url}"
    }
  end

  def subscribable
    self.web_page
  end
end
