# == Schema Information
#
# Table name: artworks
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
  validates :title, :image_url, presence: true
  validates :image_url, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id }

  belongs_to :artist,
    foreign_key: :artist_id,
    primary_key: :id,
    class_name: :User,
    dependent: :destroy

  has_many :artwork_shares,
    foreign_key: :artwork_id,
    primary_key: :id,
    class_name: :ArtworkShare,
    dependent: :destroy

  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

  has_many :comments,
    foreign_key: :artwork_id,
    primary_key: :id,
    class_name: :Comment,
    dependent: :destroy

  has_many :likes,
    as: :likeable,
    dependent: :destroy

  has_many :people_who_have_liked,
    through: :likes,
    source: :user,
    dependent: :destroy

  has_many :favorites,
    foreign_key: :artwork_id,
    primary_key: :id,
    class_name: :Favorite,
    dependent: :destroy

  has_many :people_who_have_favorited,
    through: :favorites,
    source: :user
end
