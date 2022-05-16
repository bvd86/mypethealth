class Consultation < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  has_many :messages
  has_many :feedbacks
  has_one :receipt
end
