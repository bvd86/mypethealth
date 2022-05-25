class Specialty < ApplicationRecord
  has_many :user_specialties # Have to be specified in a end-to-end relation
  has_many :users, through: :user_specialties
end
