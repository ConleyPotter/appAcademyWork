class Post < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :sub
  belongs_to :author

  has_many :post_subs
  
  has_many :subs,
    through: :post_subs,
    source: :sub 
end
