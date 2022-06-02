class Message < ApplicationRecord
  belongs_to :user
  belongs_to :consultation

  has_one_attached :photo
end
