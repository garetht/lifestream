class PostPhoto < ActiveRecord::Base
  attr_accessible :post_id, :image
  has_attached_file :image, styles: { :medium => "200x200" }

  belongs_to :post
end
