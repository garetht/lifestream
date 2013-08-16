class PostPhoto < ActiveRecord::Base
  attr_accessible :post_id, :image
  has_attached_file :image, styles: { :thumbnail => "142x142", :small => "75x75" }

  belongs_to :post

  validates :image, presence: true

  before_create :escape_file_name
  before_update :escape_file_name

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

  private
  
  def escape_file_name
    if image_file_name
      self.image.instance_write(:file_name, "#{URI.escape(image_file_name)}")
    end
  end

end
