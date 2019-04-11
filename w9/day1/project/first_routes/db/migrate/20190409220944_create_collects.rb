class CreateCollects < ActiveRecord::Migration[5.2]
  def change
    create_table :collects do |t|
      t.integer :user_id, null: false
      t.integer :artwork_id, null: false
      t.string :collection_name, null: false
      t.timestamps
    end
    add_index :collects, :user_id
    add_index :collects, [:artwork_id, :collection_name], unique: true
    add_index :collects, :collection_name
  end
end
