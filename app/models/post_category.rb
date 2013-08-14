class PostCategory < ActiveRecord::Base
  attr_accessible :category_id, :post_id

  belongs_to :post
  belongs_to :category

  validates :category_id, :post_id, presence: true
  validates :category_id, :post_id, numericality: true

end
