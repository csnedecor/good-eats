class Review < ActiveRecord::Base
  belongs_to :restaurant

  validates :rating, presence: true
  validates :rating, numericality: {only_integer: true, message: "Rating must be a whole number"}
  validates_inclusion_of :rating, {in: (1..5),
    message: "Rating must be between 1 and 5"}
  validates :body, presence: true
end
