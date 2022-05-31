class Specialty < ApplicationRecord
  has_many :user_specialties # Have to be specified in a end-to-end relation
  has_many :users, through: :user_specialties

  SPECIALTIES = {
    "Avians" => %w[ bird chicken owl parrot cockatoo budgy],
    "Equines" => %w[ horse pony ],
    "Beef Cattles" => %w[ cow ],
    "Felines" => %w[ cat lynx tiger ],
    "Canines" => %w[ dog ],
    "Exotic Mammals" => %w[ exotic ],
    "Dairy Mammals" => %w[ cow  goat ],
    "Reptile" => %w[ snake turtle lizard iguana ],
    "Amphibian" => %w[ frog ],
    "Rodent" => %w[ mouse hamster chinchilla ]
  }

end
