module Toyable
  extend ActiveSupport::Concern

  included do 
    has_many :toys, as: :toyable, dependent: :destroy
  end

  def receive_toy(name)
    toy = Toy.find_by_or_create(name: name, toyable_id = self.id, toyable_type = self.class.to_s)
    
    self.toy_ids << toy.id
    self.save
  end
end