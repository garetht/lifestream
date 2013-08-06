class Post < ActiveRecord::Base
  attr_accessible :body, :title, :content_type, :post_photos_attributes, :stream_id

  belongs_to :stream
  has_many :post_photos

  accepts_nested_attributes_for :post_photos
end
