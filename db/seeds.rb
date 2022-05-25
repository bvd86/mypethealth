# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Consultation.destroy_all
User.destroy_all

# Seeding vet specialties
unless Specialty.any?
  specialties = ["Avians",
    "Equines",
    "Beef Cattles",
    "Felines",
    "Canines",
    "Exotic Mammals",
    "Dairy Mammals",
    "Reptile and Amphibian"]

  specialties.each do |s|
    specialty = Specialty.new
    specialty.name = s
    specialty.save!
    p "Saved #{s} as a vet' specialty."
  end
end

vet_1 = User.create!({
  email: "drfraisse@mypethealth.ca",
  password: "123456",
  name: "Nicolas Fraisse",
  address: "391 Rue de la Congrégation, Montreal QC",
  vet_specialty: "TBD"})

client_1 = User.create!({ email: "jeff@ilovecats.com", password: "123456", name: "Jeff Trempe", address: "1940 Jolicoeur Street, Montreal QC" })

client_2 = User.create!({ email: "krystina@ilovedogs.com", password: "123456", name: "Krystina Dierstein", address: "596 Blou Bourg-Neuf, Repentigny, QC" })

# Adding 3 cats for client_1
3.times do
  Pet.create!({ user: client_1, name: Faker::Creature::Cat.name, species: "Cat", breed: Faker::Creature::Cat.breed })
end
# Adding 2 horses for client_1
2.times do
  Pet.create!({ user: client_1, name: Faker::Creature::Horse.name, species: "Horse", breed: Faker::Creature::Horse.breed})
end

# Adding 4 dogs for client_2
4.times do
  Pet.create!({ user: client_2, name: Faker::Creature::Dog.name, species: "Dog", breed: Faker::Creature::Dog.breed})
end

types_of_concern = ["Behavior", "Dental", "End of Life", "Physical Activity", "Medication Nutrition Welfare"]

3.times do
  Consultation.create!({
    user: vet_1,
    pet: client_1.pets.sample,
    concern_category: types_of_concern.sample,
    additional_info: Faker::Marketing.buzzwords
  })
end

2.times do
  Consultation.create!({
    user: vet_1,
    pet: client_2.pets.sample,
    concern_category: types_of_concern.sample,
    additional_info: Faker::Marketing.buzzwords
  })
end
