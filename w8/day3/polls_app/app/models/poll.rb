class Poll < ApplicationRecord 
  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User

  has_many :questions,
    primary_key: :id,
    foreign_key: :id,
    class_name: :Question
end