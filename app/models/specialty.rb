class Specialty < ApplicationRecord
  has_many :user_specialties # Have to be specified in a end-to-end relation
  has_many :users, through: :user_specialties

  SPECIALTIES = {
    "Avians" => %w[ bird chicken owl parrot cockatoo budgy],
    "Equines" => %w[ horse pony ],
    "Farm Animals" =>[ "cow", "beef cattles", "farm animals"],
    "Felines" => %w[ cat lynx tiger ],
    "Canines" => %w[ dog ],
    "Exotic Mammals" => [ "exotic", "exotic mammals"],
    "Dairy Mammals" => %w[ cow  goat ],
    "Reptile and Amphibian" => %w[ snake turtle lizard iguana frog ],
    "Rodent" => %w[ mouse hamster chinchilla ]
  }

end
