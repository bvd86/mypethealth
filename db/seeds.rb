# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'
require 'json'


TEACHERS = {
  teacher1: {
    name: "Kristyna Dierstein",
    address: Faker::Address.full_address,
    username: "kristynadierstein",
  },
  teacher2: {
    name: "Jeff Trempe",
    address: Faker::Address.full_address,
    username: "JefGreen",
  },
  teacher3: {
    name: "Frederic Charest",
    address: Faker::Address.full_address,
    username: "aquidam",
  },
  teacher4: {
    name: "Solene Duprat",
    address: Faker::Address.full_address,
    username: "aquidam",
  }
}

def find_pic(username)
  url = "https://api.github.com/users/#{username}"
  user_serialized = URI.open(url).read
  user = JSON.parse(user_serialized)
  user["avatar_url"]
end


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
    "Farm Animals",
    "Felines",
    "Canines",
    "Exotic Mammals",
    "Dairy Mammals",
    "Reptile and Amphibian",
    "Generalist"]

  specialties.each do |s|
    specialty = Specialty.new
    specialty.name = s
    specialty.save!
    p "Saved #{s} as a vet' specialty."
  end
end

# ========================
# Creating vet
# ========================
vet_1 = User.create!({
  email: "drfraisse@mypethealth.ca",
  password: "123456",
  name: "Nicolas Fraisse",
  address: "391 Rue de la Congrégation, Montreal QC",
  available: true})

# Add vet photo
file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1570482026/xlayp6fkanfrqzwlg1eu.jpg')
vet_1.photo.attach(io: file, filename: 'nic-avatar.jpg', content_type: 'image/jpg')
# Adding 2 specialties to vet
vet_1.specialties = [Specialty.find_by(name:"Canines"), Specialty.find_by(name:"Felines"), Specialty.find_by(name:"Generalist") ]


vet_2 = User.create!({
  email: "drlafontaine@mypethealth.ca",
  password: "123456",
  name: "Stephane Lafontaine",
  address: "1155 rue Metcalfe, Montreal QC",
  available: true})

# Add vet photo
file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1652365690/ygqzrfi0zo1jpj6y4lwa.jpg')
vet_2.photo.attach(io: file, filename: 'stephane-avatar.jpg', content_type: 'image/jpg')
# Adding 2 specialties to vet
vet_2.specialties = [Specialty.find_by(name:"Equines"), Specialty.find_by(name:"Farm Animals")]

vet_3 = User.create!({
  email: "drleger@mypethealth.ca",
  password: "123456",
  name: "Enya Leger",
  address: "2209 ave du Mont-Royal Est, Montreal QC",
  available: true})

# Add vet photo
file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1641386359/dhel4rtasvauuahid89k.jpg')
vet_3.photo.attach(io: file, filename: 'enya-avatar.jpg', content_type: 'image/jpg')
# Adding 2 specialties to vet
vet_3.specialties = [Specialty.find_by(name:"Felines"), Specialty.find_by(name:"Exotic Mammals")]


# TEACHERS.each do |k, v|
#   pic = find_pic(k[:username])
#   vet = User.create!({
#     email: "#{k[:name]}@mypethealth.ca",
#     password: "123456",
#     name: k[:name],
#     address: k[:address],
#     available: true
#   })
#    # Add vet photo
#   vet.photo.attach(io: pic, filename: 'user-avatar.jpg', content_type: 'image/jpg')
#   p "#{vet.name} has been created"

# end



# ======================
# Creating clients
# ======================
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
15.times do
  user = User.create!({
  email: Faker::Internet.email,
  password: "password",
  name: Faker::FunnyName.two_word_name,
  address: Faker::Address.full_address,
  available: true})

  user.specialties = Specialty.all.sample(2)

  # Add vet photo
  file = URI.open('https://source.unsplash.com/random/?face-avatar')
  user.photo.attach(io: file, filename: 'user-avatar.jpg', content_type: 'image/jpg')
  # Adding 2 specialties to vet

end

p "Seeding is complete."
