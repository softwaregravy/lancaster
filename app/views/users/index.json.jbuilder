json.array!(@users) do |user|
  json.extract! user, :id, :email, :phone_number, :notifications_enabled
  json.url user_url(user, format: :json)
end
