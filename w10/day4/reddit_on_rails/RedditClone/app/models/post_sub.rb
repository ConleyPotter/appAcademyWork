class PostSub < ApplicationRecord

  belongs_to :post, 
    foreign_key: :post_id, 
    primary_key: :id, 
    class_name: :Post 

  belongs_to :sub, 
    foreign_key: :sub_id, 
    primary_key: :id, 
    class_name: :Sub 
end
