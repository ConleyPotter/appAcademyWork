class User < ApplicationRecord
  has_many :authored_polls,
    foreign_key: :id, 
    primary_key: :id,
    class_name: :Poll

  has_many :responses,
    foreign_key: :id,
    primary_key: :id,
    class_name: :Response
end