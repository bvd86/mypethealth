# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

p "Destroying old seeds..."

Message.destroy_all
Feedback.destroy_all
Receipt.destroy_all
Consultation.destroy_all
UserSpecialty.destroy_all
Specialty.destroy_all
User.destroy_all

p "Done."


p "Starting new seeds..."


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

# Creating vet
vet_1 = User.create!({
  email: "drfraisse@mypethealth.ca",
  password: "123456",
  name: "Nicolas Fraisse",
  address: "391 Rue de la Congrégation, Montreal QC",
  available: true})

# Adding 2 specialties to vet
vet_1.specialties = Specialty.all.sample(2)

# Creating client 1
client_1 = User.create!({ email: "jeff@ilovecats.com", password: "123456", name: "Jeff Trempe", address: "1940 Jolicoeur Street, Montreal QC" })

# Creating client 2
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

types_of_concern = ["Behavior", "Dental", "End of Life", "Physical Activity", "Medication", "Nutrition", "Welfare"]

# Seeding consultations for vet with client 1
3.times do
  Consultation.create!({
    user: vet_1,
    vet_id: vet_1.id,
    pet: client_1.pets.sample,
    concern_category: Consultation::CONCERN.sample,
    additional_info: Faker::Marketing.buzzwords
  })
end

# Seeding consultations for vet with client 2
2.times do
  Consultation.create!({
    user: vet_1,
    vet_id: vet_1.id,
    pet: client_2.pets.sample,
    concern_category: types_of_concern.sample,
    additional_info: Faker::Marketing.buzzwords
  })
end

# Creating random vets to populate vets list
5.times do
  user = User.create!({
  email: Faker::Internet.email,
  password: "password",
  name: Faker::FunnyName.two_word_name,
  address: Faker::Address.full_address,
  available: true})

  user.specialties = Specialty.all.sample(2)
end

p "Seeding is complete."
