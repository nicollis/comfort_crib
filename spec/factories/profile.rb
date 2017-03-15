FactoryGirl.define do
  factory :profile do
    guest
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    zipcode { Faker::Address.zip_code }
    phone { Faker::PhoneNumber.phone_number }
    bio { Faker::Lorem.paragraph(2) }
    avatar { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/avatar.png'))) }
  end
end
