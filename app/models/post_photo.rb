class PostPhoto < ActiveRecord::Base
  attr_accessible :post_id, :image
  has_attached_file :image, styles: { :medium => "200x200" },
          path: ":rails_root/images/:id/:basename.:extension"

  belongs_to :post
end
