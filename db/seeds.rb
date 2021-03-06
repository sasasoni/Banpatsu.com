# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "Example User",
  circle_name: "Example Club",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  twitter_name: "TwitterDev",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

99.times do |n|
  name = Faker::Name.name + "-#{n+1}"
  circle_name = name + "\'s Club"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    circle_name: circle_name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.order(:created_at).take(6)
10.times do
  title = Faker::Lorem.sentence(5)
  description = Faker::Lorem.sentence(20)
  users.each do |user|
    user.events.create!(
      title: "Test:" + title,
      description: description,
      start_date: Time.current.advance(days: rand(20))
    )
  end
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }