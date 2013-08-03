class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end

    add_index :streams, :user_id
  end
end
