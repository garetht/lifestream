class PostPhoto < ActiveRecord::Base
  attr_accessible :post_id, :image
  has_attached_file :image, styles: { :thumbnail => "150x150" }

  belongs_to :post

  validates :image, presence: true
  validates_attachment_content_type :image, content_type: "image"

  def json_data
    {
      "name" => read_attribute(:image_file_name),
      "size" => read_attribute(:image_file_size),
      "url" => image.url(:original),
      "delete_url" => "/post_photos/#{id}",
      "delete_type" => "DELETE"
    }
  end
end
