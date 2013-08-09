class PostPhoto < ActiveRecord::Base
  attr_accessible :post_id, :image
  has_attached_file :image, styles: { :thumbnail => "150x150" }

  belongs_to :post
end
