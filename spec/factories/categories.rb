require 'faker'

FactoryGirl.define do
  factory :category do |f|
    f.id {Faker::Number.digit}
    f.parent_id {Faker::Number.digit}
    f.user_id 1
    f.name {Faker::Lorem.word}
  end
end