class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :content_type
      t.string :public_type
      t.boolean :is_draft

      t.timestamps
    end
  end
end
