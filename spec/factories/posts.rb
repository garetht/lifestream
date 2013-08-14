require 'faker'

FactoryGirl.define do
  factory :post do |f|
    f.stream_id {Faker::Number.digit}
    f.title {Faker::Lorem.words(num = 3)}
    f.body {Faker::Lorem.paragraphs(paragraph_count = 3)}
    f.content_type "plaintext"
    f.public_type "public"
    f.is_draft false
    f.latitude 40.7308443
    f.longitude -73.99136419999999
    f.location "756-770 Broadway, New York, NY 10003, USA"
    f.gmaps true
  end
end