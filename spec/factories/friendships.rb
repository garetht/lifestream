require 'faker'

FactoryGirl.define do
  factory :friendship do |f|
    f.id {Faker::Number.digit}
    f.user_id {Faker::Number.digit}
    f.friend_id {Faker::Number.digit}
    f.friend_status "confirmed"
  end
end