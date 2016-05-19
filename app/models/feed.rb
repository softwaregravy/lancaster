# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

class Feed < ActiveRecord::Base
  has_many :subscriptions
  has_many :posts

  validates :url, uri: true, presence: true
  before_save :verify_feed, if: Proc.new {|f| new_record? || url_changed? }

  def display_name
    name || title
  end

  def fetch_latest_post(send_updates = false)
    post = latest_post
    #TODO critical path here for threadsafety. can I lock it?
    #mitigate: locked in the db, so I guess first one through wins
    my_post = posts.find_or_initialize_by(title: post.title, url: post.url) 
    if my_post.new_record? && send_updates
      my_post.save!
      PrepareFeedNotificationsWorker.perform_async(my_post.id) 
    else
      my_post.save!
    end
    my_post
  end

  def fetch_and_parse
    Rails.cache.fetch('feed', expires_in: 900) do 
      Feedjira::Feed.fetch_and_parse url
    end
  end

  def latest_post
    fetch_and_parse.entries.first
  end

  def latest_title_and_link
    post = latest_post
    [post.title, post.url]
  end

  def verify_feed
    if url.present?
      feedjira = fetch_and_parse
      self.title = feedjira.title
      unless title.present?
        self.title = Addressable::URI.parse(url).host
      end
    end
  end
end

