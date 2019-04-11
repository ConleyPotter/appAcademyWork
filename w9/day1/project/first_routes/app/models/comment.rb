# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  artwork_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :string           not null
#

class Comment < ApplicationRecord
  validates :user_id, :artwork_id, :body, presence: true

  belongs_to :author,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  belongs_to :artwork,
    foreign_key: :artwork_id,
    primary_key: :id,
    class_name: :Artwork

  has_many :likes,
    as: :likeable,
    dependent: :destroy

  has_many :people_who_have_liked,
    through: :likes,
    source: :user,
    dependent: :destroy
end
