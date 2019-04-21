class CreatePostSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_subs do |t|
      t.integer :post_id
      t.integer :sub_id

      t.timestamps
    end
    add_index :post_subs, :post_id 
    add_index :post_subs, :sub_id 
    add_index :post_subs, [:post_id, :sub_id]
  end
end
