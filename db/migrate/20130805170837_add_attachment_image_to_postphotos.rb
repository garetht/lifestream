class AddAttachmentImageToPostphotos < ActiveRecord::Migration
  def self.up
    change_table :post_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :post_photos, :image
  end
end
