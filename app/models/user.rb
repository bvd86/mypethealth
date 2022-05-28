class User < ApplicationRecord
  has_one_attached :photo
  has_many :pets, dependent: :destroy
  has_many :consultations
  has_many :feedbacks
  has_many :messages

  # Has to be specified in a end-to-end relation
  has_many :user_specialties

  # Allows to force a uniq specialty and avoid associations duplications
  has_many :specialties, -> { distinct }, through: :user_specialties

  # For the notification system for vets
  has_many :notifications, as: :recipient

  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
