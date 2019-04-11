# require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all
Comment.destroy_all
Like.destroy_all
Favorite.destroy_all
UserCollection.destroy_all
CollectionsOfArtwork.destroy_all

20.times do
  User.create!(username: Faker::Internet.unique.username)
end

20.times do
  Artwork.create!(artist_id: User.all.sample.id, 
                  image_url: Faker::Internet.unique.url,
                  title: Faker::Lorem.word)
end

15.times do 
  users = User.all
  user = users.sample
  ArtworkShare.create!(viewer_id: user.id,
                        artwork_id: Artwork.all.sample.id)
  users -= [user]
end

40.times do 
  Comment.create!(user_id: User.all.sample.id,
                  artwork_id: Artwork.all.sample.id,
                  body: Faker::Lorem.sentence)
end

likeable = 0
19.times do
  Like.create!(user_id: User.all.sample.id,
              likeable_id: (likeable % 2 == 0 ? Artwork.all.sample.id : Comment.all.sample.id),
              likeable_type: (likeable % 2 == 0 ? 'Artwork' : 'Comment'))
  likeable += 1
end

15.times do
  Favorite.create!(user_id: User.all.sample.id,
                  artwork_id: Artwork.all.sample.id)
end

21.times do
  UserCollection.create!(user_id: User.all.sample.id,
                        collection_name: Faker::Lorem.word)
end

21.times do
  CollectionsOfArtwork.create!(artwork_id: Artwork.all.sample.id,
                              collection_id: UserCollection.all.sample.id)
end