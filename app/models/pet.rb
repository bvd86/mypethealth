class Pet < ApplicationRecord
  belongs_to :user
  has_many :consultations

  # has_one_attached :photo
end
