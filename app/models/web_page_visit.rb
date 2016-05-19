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
  validates_presence_of :checksum, :size

  class << self
    def visit(web_page)
      page_contents = fetch_page(web_page)
      digest = Digest::MD5.new.hexdigest(page_contents)
      web_page.web_page_visits.create({size: page_contents.size, checksum: digest})
    end

    def fetch_page(web_page)
      page = open(web_page.url)
      page.read
    end
  end

end
