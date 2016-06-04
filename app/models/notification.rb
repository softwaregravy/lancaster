# == Schema Information
#
# Table name: notifications
#
#  id                       :integer          not null, primary key
#  subject                  :string
#  body                     :string
#  short_message            :string
#  notification_source_id   :integer
#  notification_source_type :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Notification < ActiveRecord::Base
  belongs_to :notification_source, polymorphic: true
end
