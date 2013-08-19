class Post < ActiveRecord::Base
  attr_accessible :body, :title, :content_type, :post_photos_attributes, 
                  :stream_id, :category_ids, :latitude, :longitude,
                  :location, :public_type, :post_photo_ids

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

  def static_map_url
    "http://maps.googleapis.com/maps/api/staticmap?center=" \
    "#{URI.escape location}&zoom=14&size=630x330&maptype=roadmap" \
    "&markers=color:red%7C#{latitude},#{longitude}&sensor=false" \
    "&visual_refresh=true&scale=2"
  end

  def get_set_categories
    Category.joins(:post_categories).where("post_id = ?", id).pluck(:name)
  end

end
