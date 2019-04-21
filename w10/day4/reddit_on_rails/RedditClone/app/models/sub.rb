class Sub < ApplicationRecord 
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator,
    foreign_key: :moderator_id, 
    primary_key: :id, 
    class_name: :User

  has_many :post_subs 

  has_many :posts,
    through: :post_subs,
    source: :post 
end  