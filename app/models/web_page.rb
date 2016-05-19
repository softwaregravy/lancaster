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

  validates :url, uri: true, presence: true

  def visit!
    WebPageVisit.visit(self)
  end

  def page_contents_changed?
    # base case when we're a new page
    return false unless web_page_visits.count > 1

    visits = WebPageVisit.last(2)
    return visits.first.checksum != visits.second.checksum
  end
end
