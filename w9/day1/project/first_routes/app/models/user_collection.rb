class UserCollection < ApplicationRecord
  validates :user_id, :collection_name, presence: true
  validates :collection_name, uniqueness: { scope: :user_id }

  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  has_one :collection_of_art,
    foreign_key: :collection_id,
    primary_key: :id,
    class_name: :CollectionsOfArtwork,
    dependent: :destroy
end