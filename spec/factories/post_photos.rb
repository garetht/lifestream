require 'faker'

FactoryGirl.define do
  factory :post_photo do |f|
    f.id {Faker::Number.digit}
    f.post_id {Faker::Number.digit}
  end
end