class Specialty < ApplicationRecord
  has_many :user_specialties # Have to be specified in a end-to-end relation
  has_many :users, through: :user_specialties

  SPECIALTIES = {
    "Avians" => %w[ bird chicken owl parrot cockatoo budgy],
    "Equines" => %w[ horse pony ],
    "Beef Cattles" => %w[ cow ],
    "Felines" => %w[ cat lynx tiger ],
    "Canines" => %w[ dog ],
    "Exotic Mammals" => "",
    "Dairy Mammals" => %w[ cow  goat ],
    "Reptile" => "",
    "Amphibian" => %w[ frog ]
  }

end
