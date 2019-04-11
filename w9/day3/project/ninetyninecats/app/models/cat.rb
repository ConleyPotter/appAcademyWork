class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  COLORS = { in: [:white, :black, :calico, :tan, :grey] }

  validates :birthdate, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: { in: ["M", "F"] }
  
  def age
    distance_of_time_in_words(birthdate, DateTime.now)
  end

end