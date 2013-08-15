class PostPhoto < ActiveRecord::Base
  attr_accessible :post_id, :image
  has_attached_file :image, styles: { :thumbnail => "150x150", :small => "75x75" }

  belongs_to :post

  validates :image, presence: true

  def json_data
    {
      "name" => read_attribute(:image_file_name),
      "id" => "#{id}",
      "size" => read_attribute(:image_file_size),
      "url" => image.url(:original),
      "thumbnail_url" => image.url(:small),
      "delete_url" => "/post_photos/#{id}",
      "delete_type" => "DELETE"
    }
  end
end
