class User < ApplicationRecord
  has_many :pets
  has_many :consultations
  has_many :feedbacks
  has_many :messages
  has_many :user_specialties # Have to be specified in a end-to-end relation
  has_many :specialties, through: :user_specialties

  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
