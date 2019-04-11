# == Schema Information
#
# Table name: favorites
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  artwork_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Favorite < ApplicationRecord
  validates :artwork_id, uniqueness: { scope: :user_id }
  validates :artwork_id, :user_id, presence: true

  belongs_to :user
  belongs_to :artwork
end
