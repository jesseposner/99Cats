# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  User.create(user_name: Faker::Internet.user_name, password: Faker::Internet.password )
end

100.times do
  Cat.create(birth_date: Faker::Date.backward(5000), color: ["black", "white", "orange", "brown"].sample,
  name: Faker::Name.name, sex: ["M", "F"].sample, user_id: rand(205)+1
  )
end


Cat.create(birth_date: Faker::Date.backward(5000), color: ["black", "white", "orange", "brown"].sample,
name: Faker::Name.name, sex: ["M", "F"].sample, user_id: 204)

100.times do
  start_date = Faker::Date.backward(5000)
  CatRentalRequest.create(cat_id: rand(205)+1, start_date: start_date, end_date: start_date + rand(20), user_id: rand(205)+1)
end
