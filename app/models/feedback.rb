class Feedback < ApplicationRecord
  belongs_to :consultation
  belongs_to :user

  STARS = (1..5).to_a
end
