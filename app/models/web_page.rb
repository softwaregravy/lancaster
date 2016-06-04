# == Schema Information
#
# Table name: web_pages
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WebPage < ActiveRecord::Base
  # WARNING! method page_contents_changed? below will collide 
  # with ActiveRecord if field page_contents added
  # tldr: don't create field page_contents
 
  has_many :web_page_visits
  has_many :subscriptions, as: :subscribable

  validates :url, uri: true, presence: true

  def display_name
    Addressable::URI.parse(url).host
  end

  def visit
    web_page_visits.last
  end

  def visit!
    page = open(url)
    page_contents = page.read
    digest = Digest::MD5.new.hexdigest(page_contents)
    web_page_visits.create({size: page_contents.size, checksum: digest})
  end

  def page_contents_changed?
    # base case when we're a new page
    return false unless web_page_visits.count > 1

    visits = WebPageVisit.last(2)
    return visits.first.checksum != visits.second.checksum
  end
end
