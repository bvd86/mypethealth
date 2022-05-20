# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
