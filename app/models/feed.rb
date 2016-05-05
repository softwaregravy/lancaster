# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feed < ActiveRecord::Base
  validates_presence_of :name, :url
  validates :url, presence: true

  def fetch_and_parse
    @cached_feed = Feedjira::Feed.fetch_and_parse url
  end

  def latest_post
    fetch_and_parse unless @cached_feed
    @cached_feed.entries.first
  end

  def latest_title_and_link
    [latest_post.title, latest_post.url]
  end
end
