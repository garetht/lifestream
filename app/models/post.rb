class Post < ActiveRecord::Base
  attr_accessible :body, :title, :content_type, :post_photos_attributes, 
                  :stream_id, :category_ids, :latitude, :longitude,
                  :location, :public_type

  belongs_to :stream
  has_many :post_photos

  has_many :post_categories
  has_many :categories, through: :post_categories

  has_many :comments

  acts_as_gmappable

  accepts_nested_attributes_for :post_photos

  validates :body, presence: true
  validates :public_type, inclusion: {:in => ["public", "private"]}
  validates :content_type, inclusion: {:in => ["plaintext", "markdown"]}

  def gmaps4rails_address
    "#{self.location}"
  end
end
