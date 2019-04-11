class CollectionsOfArtwork < ApplicationRecord
  validates :artwork_id, :collection_id, presence: true

  belongs_to :artwork,
    foreign_key: :artwork_id,
    primary_key: :id,
    class_name: :Artwork

  belongs_to :collection,
    foreign_key: :collection_id,
    primary_key: :id,
    class_name: :UserCollection
end