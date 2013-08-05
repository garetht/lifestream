class CreatePostPhotos < ActiveRecord::Migration
  def change
    create_table :post_photos do |t|
      t.integer :post_id

      t.timestamps
    end
  end
end
