# require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)





User.destroy_all
20.times do
  User.create!(username: Faker::Internet.unique.username)
end

Artwork.destroy_all
20.times do
  Artwork.create!(artist_id: User.all.sample.id, 
                  image_url: Faker::LoremFlickr.image,
                  title: Faker::Lorem.word)
end

ArtworkShare.destroy_all
20.times do 
  ArtworkShare.create!(viewer_id: User.all.sample.id,
                        artwork_id: Artwork.all.sample.id)
end