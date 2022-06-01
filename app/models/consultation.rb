class Consultation < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  has_many :messages
  has_one :feedback
  has_one :receipt

  CONCERN = ["Behavior", "Dental", "End of Life", "Medication", "Nutrition", "Physical Activity", "Welfare", "Other"]
end
