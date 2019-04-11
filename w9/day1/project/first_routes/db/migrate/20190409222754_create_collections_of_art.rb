class CreateCollectionsOfArt < ActiveRecord::Migration[5.2]
  def change
    create_table :collections_of_artworks do |t|
      t.integer :artwork_id, null: false
      t.integer :collection_id, null: false
    end
    add_index :collections_of_artworks, :collection_id
  end
end
