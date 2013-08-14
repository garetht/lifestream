require 'faker'

FactoryGirl.define do
  factory :comment do |f|
    f.id {Faker::Number.digit}
    f.parent_id {Faker::Number.digit}
    f.user_id 1
    f.post_id 3
    f.text {Faker::Lorem.sentence(word_count = 6)}
  end
end