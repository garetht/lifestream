require 'faker'

FactoryGirl.define do
  factory :stream do |f|
    f.id {Faker::Number.digit}
    f.user_id {Faker::Number.digit}
    f.name {Faker::Lorem.word}
  end
end