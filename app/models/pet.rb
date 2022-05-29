class Pet < ApplicationRecord
  belongs_to :user
  has_many :consultations

  has_one_attached :photo

  SPECIES = ['Dog', 'Cat', 'Bird', 'Horse', 'Rodent', 'Fish', 'Exotic animals', 'Farm animals', 'Reptile', 'Other'].freeze

  validates :species, inclusion: { in: SPECIES }
end
