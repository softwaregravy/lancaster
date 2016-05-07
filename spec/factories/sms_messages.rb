# == Schema Information
#
# Table name: sms_messages
#
#  id             :integer          not null, primary key
#  send_initiated :datetime
#  send_completed :datetime
#  retry_enabled  :boolean          default("true"), not null
#  max_retries    :integer          default("0"), not null
#  user_id        :integer          not null
#  post_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :sms_message do
    send_initiated nil
    send_completed nil
    retry_enabled true
    max_retries 1
    user 
    post
  end
end
