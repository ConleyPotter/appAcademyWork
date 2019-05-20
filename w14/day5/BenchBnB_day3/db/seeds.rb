# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Bench.destroy_all

bench1 = Bench.create(description: Faker::Lorem.sentence(4), lat: 37.750493, lng: -122.452035)
bench2 = Bench.create(description: Faker::Lorem.sentence(4), lat: 37.722907, lng: -122.408157)
bench3 = Bench.create(description: Faker::Lorem.sentence(4), lat: 37.724961, lng: -122.407213)
bench4 = Bench.create(description: Faker::Lorem.sentence(4), lat: 37.782994, lng: -122.418445)
bench5 = Bench.create(description: Faker::Lorem.sentence(4), lat: 37.803404, lng: -122.434394)
bench6 = Bench.create(description: Faker::Lorem.sentence(4), lat: 37.730641, lng: -122.399616)
