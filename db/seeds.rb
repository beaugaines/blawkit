# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

u = User.create(username: 'blawkitter', email: 'guy@email.com', password: 'password')
u2 = User.create(username: 'kittblawker', email: 'othaguy@email.com', password: 'password')
a = User.create(username: 'admin', email: 'admin@blawkit.com', password: 'password')
users = %w(u u2)
users.each { |u| u.confirm! }

rand(10..30).times do
  p = u.posts.create(title: Faker::HipsterIpsum.words(rand(1..10)).join(" "),
    body: Faker::HipsterIpsum.paragraphs(rand(1..4)).join("\n"))
  rand(3..5).times do
    p.comments.create(body: Faker::HipsterIpsum.paragraphs(rand(1..3)).join("\n"), user_id: users.sample)
  end
  rand(0..1).times do
    p.comments.create(body: 'This comment is inappropriate and will be removed.', user_id: a.id)
  end
end

puts 'Seed finished'

puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"