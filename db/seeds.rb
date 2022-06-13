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

p "Old data has been cleaned!"


p "Starting new seeds..."

# =============================================
# Seeding vets' specialties in DB
# =============================================

p "Seeding vets' specialties..."

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

p "vets' specialties created."

# =============================================
# Creating vet
# =============================================

p "Seeding vets..."

9.times do
  user = User.create!({
  email: Faker::Internet.email,
  password: "password",
  name: "#{Faker::Name.male_first_name} #{Faker::Name.last_name}",
  address: Faker::Address.full_address,
  available: true})

  # Adding 2 specialties to vet
  user.specialties = Specialty.all.sample(2)
  p "#{user.name} created."
end

5.times do
  user = User.create!({
  email: Faker::Internet.email,
  password: "password",
  name: "#{Faker::Name.female_first_name} #{Faker::Name.last_name}",
  address: Faker::Address.full_address,
  available: true})

  # Adding 2 specialties to vet
  user.specialties = Specialty.all.sample(2)

  p "#{user.name} created."
end

# Random vet photos

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

# Attach vet photos to vet users
User.all.each_with_index do |u, i|

  # Add vet photo
  file = URI.open(vet_photos[i])
  u.photo.attach(io: file, filename: 'user-avatar.jpg', content_type: 'image/jpg')

  p "#{u.name}'s photo attached."
end

#-----------------------
# Creating specific vets
#-----------------------
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

p "#{vet_1.name} created."

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

p "#{vet_2.name} created."

# =============================================
# Creating DEMO VET account
# =============================================

vet_3 = User.create!({
  email: "drsmith@mypethealth.ca",
  password: "123456",
  name: "Eric Smith",
  address: "2209 ave du Mont-Royal Est, Montreal QC",
  available: false})

# Add vet photo
file = URI.open('https://img.freepik.com/free-photo/portrait-successful-mid-adult-doctor-with-crossed-arms_1262-12865.jpg?t=st=1654821269~exp=1654821869~hmac=0f098bd9462ad511c7d477a1f1459a2e48d03ae707572e5b09f2ae96c7d36d90&w=1800')
vet_3.photo.attach(io: file, filename: 'eric-avatar.jpg', content_type: 'image/jpg')
# Adding 2 specialties to vet
vet_3.specialties = [Specialty.find_by(name:"Felines"), Specialty.find_by(name:"Exotic Mammals")]

p "#{vet_3.name} created."

p "Vets added!"

vet_pet = Pet.create!({
  name: "Abricot",
  species: "Cat",
  breed: "Mixed",
  user: vet_3
})

vet_pet.photo.attach(io: File.open('app/assets/images/abricot.png'), filename: 'abricot.png', content_type: 'image/png')
vet_pet.save!

p "Pet #{vet_pet.name} created."

# =============================================
# Creating DEMO CLIENT account
# =============================================

p "Creating User Profile for Demo."

client = User.create!({
  email: "billy@mypethealth.ca",
  password: "123456",
  name: "Billy Veillette-Daigle",
  address: "2209 ave du Mont-Royal Est, Montreal QC"
  })

p "#{client.name} created."

pet = Pet.create!({
  name: "Charlie",
  species: "Dog",
  breed: "Toy Poodle",
  user: client
})

pet.photo.attach(io: File.open('app/assets/images/charlie.jpg'), filename: 'charlie.jpg', content_type: 'image/jpg')
pet.save!

p "Pet #{pet.name} created."

consultation = Consultation.create!({
  user: client,
  pet: pet,
  vet_id: User.find_by(name: "Fannie Belanger").id,
  active: false
})

p "Consultation created."

#---------------------------------------------------
# Creating previous consulations in DB for all users
#---------------------------------------------------

p "Creating consultations history."
p "This may take a while...."

users = User.all

users.each do |u|
  if u.pets.count == 0
    pet = Pet.create!({
      user: u,
      name: Faker::FunnyName.two_word_name.delete(' '),
      species: Pet::SPECIES.sample,
      breed: Faker::Lorem.word
    })
  end
  if u.consultations.count == 0
    rand(5..15).times do
      consultation = Consultation.create!({
        user: u,
        pet: pet,
        concern_category: Consultation::CONCERN.sample,
        additional_info: Faker::Lorem.paragraph,
        vet_id: User.where(available: true).sample.id,
        active: false,
        species: pet.species,
        price_cents: 19,
        status: 'pending',
      })

      # Creation feedback for consultation
      Feedback.create!({
        user: u,
        consultation: consultation,
        rating: rand(2..5),
        vet_rating: rand(2..5),
        friend_rating: rand(3..5),
        comment: Faker::Lorem.paragraph
      })

      p "Feedback created."

      # Creating receipt for consulation
      Receipt.create!({
        consultation: consultation
      })

      p "Receipt created."
    end
  end
end

p "Consultations history created."

p "Seeding is complete."
