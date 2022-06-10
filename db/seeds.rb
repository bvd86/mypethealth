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


p "Destroying previous data..."

Notification.destroy_all
Message.destroy_all
Feedback.destroy_all
Receipt.destroy_all
Consultation.destroy_all
UserSpecialty.destroy_all
Specialty.destroy_all
User.destroy_all

p "Old data cleaned!"


p "Starting new seeds..."

p "Seeding vets' specialties..."

# Seeding vets' specialties
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

p "vets' specialties created!"

# ========================
# Creating vet
# ========================

p "Seeding vets..."

9.times do
  user = User.create!({
  email: Faker::Internet.email,
  password: "password",
  name: "#{Faker::Name.male_first_name} #{Faker::Name.last_name}",
  address: Faker::Address.full_address,
  available: true})

  p "#{user.name} created"

  # Adding 2 specialties to vet
  user.specialties = Specialty.all.sample(2)

  p "#{user.name}'s speciatlies added"
end

5.times do
  user = User.create!({
  email: Faker::Internet.email,
  password: "password",
  name: "#{Faker::Name.female_first_name} #{Faker::Name.last_name}",
  address: Faker::Address.full_address,
  available: true})

  p "#{user.name} created"

  # Adding 2 specialties to vet
  user.specialties = Specialty.all.sample(2)

  p "#{user.name}'s speciatlies added"
end

vet_photos = ["https://img.freepik.com/free-photo/smiling-handsome-young-black-male-doctor-medicine-concept_1262-12521.jpg?t=st=1654821269~exp=1654821869~hmac=6e8233ff6b4a3f0c1bff87d75fae8ce5dc8cd3f394ca10e7db502744e4fcbe7c&w=1800",
"https://img.freepik.com/free-photo/healthcare-workers-medicine-covid-19-pandemic-self-quarantine-concept-smiling-attractive-doctor-scrubs-glasses-stethoscope-neck-cross-arms-chest-ready-help-patients_1258-58772.jpg?t=st=1654821269~exp=1654821869~hmac=916e54f72f2cdf268641a34c67adc49f13c4156605a06d03f3b0527b3c1b922d&w=1800",
"https://img.freepik.com/free-photo/portrait-smiling-handsome-male-doctor-man_171337-5055.jpg?t=st=1654821269~exp=1654821869~hmac=0a3b08dcf581d0f2f77e94eebba507763134fd963d04b6642557637ae84ea8b2&w=1800",
"https://img.freepik.com/free-photo/portrait-doctor_144627-39381.jpg?t=st=1654821269~exp=1654821869~hmac=122a9ee4bf7d0e827cff44ee1530fa972c2496319332630958b1541b5dae4b20&w=1800",
"https://img.freepik.com/free-photo/portrait-smiling-young-man-doctor-with-stethoscope-standing-with-arms-folded_171337-15538.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/medium-shot-smiley-man-wearing-coat_23-2148816193.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/doctor-posing-confident-his-cabinet-near-window-african-american-doctor-during-his-work-with-patients-explaining-recipes-drug-daily-hard-work-health-lives-saving-during-epidemic_155003-39496.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/portrait-african-american-practitioner-doctor-working-hospital-office_482257-21715.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/doctor-standing-with-folder-stethoscope_1291-16.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/isolated-shotof-happy-successful-mature-senior-physician-wearing-medical-unifrom-stethoscope-having-cheerful-facial-expression-smiling-broadly-keeping-arms-crossed-chest_343059-2254.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7781.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/confident-beautiful-young-asian-female-doctor_1262-12292.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/content-young-female-doctor-posing-camera_1262-18213.jpg?size=626&ext=jpg",
"https://img.freepik.com/free-photo/medium-shot-smiley-doctor-with-coat_23-2148814212.jpg?size=338&ext=jpg"]


User.all.each do |i, u|

  # Add vet photo
  file = URI.open("#{vet_photos[i]}")
  user.photo.attach(io: file, filename: 'user-avatar.jpg', content_type: 'image/jpg')

  p "#{u.name}'s photo attached"
end

vet_1 = User.create!({
  email: "drbelanger@mypethealth.ca",
  password: "123456",
  name: "Fannie Belanger",
  address: "391 Rue de la Congrégation, Montreal QC",
  available: true})

# Add vet photo
file = URI.open('https://img.freepik.com/free-photo/pleased-young-female-doctor-wearing-medical-robe-stethoscope-around-neck-standing-with-closed-posture_409827-254.jpg?t=st=1654819726~exp=1654820326~hmac=27c981abc9cb3a0b1b8bc6cc765e135fb7191b33145a01441a1b43b75b8da960&w=1800')
vet_1.photo.attach(io: file, filename: 'fannie-avatar.jpg', content_type: 'image/jpg')
# Adding 2 specialties to vet
vet_1.specialties = [Specialty.find_by(name:"Canines"), Specialty.find_by(name:"Felines"), Specialty.find_by(name:"Generalist") ]

p "#{vet_1.name} created"

vet_2 = User.create!({
  email: "drlafontaine@mypethealth.ca",
  password: "123456",
  name: "Stephanie Lafontaine",
  address: "1155 rue Metcalfe, Montreal QC",
  available: true})

# Add vet photo
file = URI.open('https://img.freepik.com/free-photo/woman-doctor-wearing-lab-coat-with-stethoscope-isolated_1303-29791.jpg?w=1800&t=st=1654821230~exp=1654821830~hmac=ce7d765896030c4ee3e612a23b94f4f62a6aecac282af0eb440282f30fb615f4')
vet_2.photo.attach(io: file, filename: 'stephanie-avatar.jpg', content_type: 'image/jpg')
# Adding 2 specialties to vet
vet_2.specialties = [Specialty.find_by(name:"Equines"), Specialty.find_by(name:"Farm Animals")]

p "#{vet_2.name} created"

vet_3 = User.create!({
  email: "drsmith@mypethealth.ca",
  password: "123456",
  name: "Eric Smith",
  address: "2209 ave du Mont-Royal Est, Montreal QC",
  available: true})

# Add vet photo
file = URI.open('https://img.freepik.com/free-photo/portrait-successful-mid-adult-doctor-with-crossed-arms_1262-12865.jpg?t=st=1654821269~exp=1654821869~hmac=0f098bd9462ad511c7d477a1f1459a2e48d03ae707572e5b09f2ae96c7d36d90&w=1800')
vet_3.photo.attach(io: file, filename: 'eric-avatar.jpg', content_type: 'image/jpg')
# Adding 2 specialties to vet
vet_3.specialties = [Specialty.find_by(name:"Felines"), Specialty.find_by(name:"Exotic Mammals")]

p "#{vet_3.name} created"


p "Vets added!"

# ======================
# Creating clients
# ======================

p "Creating clients..."

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

p "Clients seeded!"

types_of_concern = ["Behavior", "Dental", "End of Life", "Physical Activity", "Medication", "Nutrition", "Welfare"]

p "Seeding consultations..."

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

p "Consultations seeded!"

# Creating random vets to populate vets list



p "Seeding is complete."
