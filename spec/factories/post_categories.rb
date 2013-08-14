require 'faker'

FactoryGirl.define do
  factory :post_category do |f|
    f.id {Faker::Number.digit}
    f.post_id {Faker::Number.digit}
    f.category_id {Faker::Number.digit}
  end
end