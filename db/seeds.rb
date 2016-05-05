# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = Role.find_or_create_by(name: "admin")
Role.find_or_create_by(name: "client")

if Rails.env.development?
  john = User.find_or_create_by(email: "john@example.com") do |u|
    u.phone_number = "555-555-5555"
    u.password = "jpassword"
    u.password_confirmation = "jpassword"
  end
  john.confirm
  john.roles = [admin]
end
