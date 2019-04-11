# == Schema Information
#
# Table name: likes
#
#  id            :bigint(8)        not null, primary key
#  user_id       :integer          not null
#  likeable_id   :integer          not null
#  likeable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Like < ApplicationRecord
  validates :user_id, :likeable_id, :likeable_type, presence: true
  validates :likeable_id, uniqueness: { scope: :user_id }

  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  belongs_to :likeable,
    polymorphic: true,
    foreign_key: :likeable_id,
    primary_key: :id
end
