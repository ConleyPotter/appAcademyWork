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
  validates :title, :image_url, :artist_id, presence: true
  validates :artist_id, uniqueness: { scope: :title }

  belongs_to :artist,
    foreign_key: :artist_id,
    primary_key: :id,
    class_name: :User,
    dependent: :destroy

  has_many :sharers,
    foreign_key: :artwork_id,
    primary_key: :id,
    class_name: :ArtworkShare,
    dependent: :destroy

  has_many :shared_viewers,
    through: :sharers,
    source: :viewer,
    dependent: :destroy
end
