require 'faker'
require 'action_controller/test_process'
 
# Paperclip attachments in factories, made easy based on technicalpickles
Factory.class_eval do
  def attach(name, path, content_type = nil)
    if content_type
      add_attribute name, ActionController::TestUploadedFile.new("#{RAILS_ROOT}/#{path}", content_type)
    else
      add_attribute name, ActionController::TestUploadedFile.new("#{RAILS_ROOT}/#{path}")
    end
  end
end

FactoryGirl.define do
  factory :post_photo do |f|
    f.id {Faker::Number.digit}
    f.post_id {Faker::Number.digit}
    f.attach ("calvin", "spec/photos/calvin.jpg", "image/jpg")
  end
end