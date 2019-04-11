class CreateUserCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :user_collections do |t|
      t.integer :user_id, null: false
      t.string :collection_name, null: false
      t.timestamps
    end
    add_index :user_collections, :user_id
    add_index :user_collections, [:user_id, :collection_name], unique: true
  end
end
