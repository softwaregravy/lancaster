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
  has_many :subscriptions, as: :subscribable
  has_many :posts

  validates :url, uri: true, presence: true
  before_save :verify_feed, if: Proc.new {|f| new_record? || url_changed? }

  def display_name
    name || title
  end

  def fetch_latest_post
    post = latest_post
    my_post = posts.find_by(title: post.title, url: post.url) 
    if my_post.nil?
      #TODO critical path here for threadsafety. can I lock it?
      #for now, this will just be nil, which satisfies the api
      posts.create(title: post.title, url: post.url) 
    else
      nil # only return if new
    end
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

  protected

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

end

