class Feedback < ApplicationRecord
  belongs_to :consultation
  belongs_to :user

  validates :rating, presence: true
  validates :vet_rating, presence: true
  validates :friend_rating, presence: true
  STARS = (1..5).to_a
end
