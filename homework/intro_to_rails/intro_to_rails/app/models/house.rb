class House < ActiveRecord::Base
  validates :address, presence: true
  has_many(
    :residents,
    class_name: 'Person',
    foreign_key: :house_id,
    primary_key: :id,
  )
end

House.create(address: '134 Road St').valid?