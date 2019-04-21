class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.integer :author_id

      t.timestamps
    end
    add_index :posts, :author_id
  end
end
