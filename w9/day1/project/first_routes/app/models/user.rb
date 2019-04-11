# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string
#

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :artworks,
    foreign_key: :artist_id,
    primary_key: :id,
    class_name: :Artwork,
    dependent: :destroy

  has_many :artwork_shares,
    foreign_key: :viewer_id,
    primary_key: :id,
    class_name: :ArtworkShare,
    dependent: :destroy

  has_many :shared_artworks,
    through: :artwork_shares,
    source: :artwork,
    dependent: :destroy

  has_many :comments,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Comment,
    dependent: :destroy

  has_many :likes,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Like,
    dependent: :destroy

  has_many :liked_artworks,
    through: :likes,
    source: :likeable,
    source_type: :Artwork,
    dependent: :destroy

  has_many :liked_comments,
    through: :likes,
    source: :likeable,
    source_type: :Comment,
    dependent: :destroy

  has_many :favorites,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Favorite,
    dependent: :destroy

  has_many :favorited_artworks,
    through: :favorites,
    source: :artwork

  has_many :collections,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :UserCollection,
    dependent: :destroy

  has_many :collectionsOfArtwork,
    through: :collections,
    source: :collection_of_art

  has_many :piecesInACollection,
    through: :collectionsOfArtwork,
    source: :artwork


  def self.find_by_search(substring)

    find_by = "(#{substring})"
    where("username ~* ?", find_by)
  end
end
