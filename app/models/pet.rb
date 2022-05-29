class Pet < ApplicationRecord
  belongs_to :user
  has_many :consultations

  has_one_attached :photo

  SPECIES = ['dog', 'cat', 'bird', 'horse', 'rodent', 'fish', 'exotic animals', 'farm animals', 'reptile', 'other'].freeze

  validates :species, inclusion: { in: SPECIES }
end
