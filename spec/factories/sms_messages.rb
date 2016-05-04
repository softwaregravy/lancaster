
FactoryGirl.define do 
  factory :sms_message do 
    # don't use phone_number -- it has extensions
    to { Faker::PhoneNumber.cell_phone }
    body { Faker::Lorem.words(4) }
  end
end
