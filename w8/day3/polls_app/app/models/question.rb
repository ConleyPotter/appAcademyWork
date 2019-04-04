class Question < ApplicationRecord
  belongs_to :poll,
    primary_key: :id,
    foreign_key: :id,
    class_name: :Poll
end