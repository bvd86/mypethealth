class User < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :consultations
  has_many :feedbacks
  has_many :messages

  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
