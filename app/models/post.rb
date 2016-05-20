# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string           not null
#  feed_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :feed
  has_one :notification, as: :notification_source
  validates_presence_of :title, :url, :feed

  def fetch_notification
    if self.notification.nil?
      create_notification(params_for_notification)
    end
    self.notification
  end

  def params_for_notification
    {
      short_message: "#{title} #{url}",
      subject: title,
      body: "New Post from Feed: #{feed.name}. Find it here: #{url}"
    }
  end

  def subscribable
    self.feed
  end
end
