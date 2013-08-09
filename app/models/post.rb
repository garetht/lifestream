class Post < ActiveRecord::Base
  attr_accessible :body, :title, :content_type, :post_photos_attributes, 
                  :stream_id, :category_ids, :latitude, :longitude,
                  :location

  belongs_to :stream
  has_many :post_photos

  has_many :post_categories
  has_many :categories, through: :post_categories

  accepts_nested_attributes_for :post_photos

  acts_as_gmappable

  def gmaps4rails_address
    "#{self.location}"
  end
end
