# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

User.delete_all
Post.delete_all
Comment.delete_all

class User
  def skip_confirm
    skip_confirmation!
    save!
  end
end


u = User.new(username: 'blawkitter', email: 'guy@email.com', password: 'password')
u.skip_confirm

u2 = User.new(username: 'kittblawker', email: 'othaguy@email.com', password: 'password')
u2.skip_confirm

a = User.new(username: 'admin', email: 'admin@blawkit.com', password: 'password')
a.skip_confirm

USERS = [u, u2]

rand(10..30).times do
  p = u.posts.create(title: Faker::HipsterIpsum.words(rand(1..10)).join(" ").titleize,
    body: Faker::HipsterIpsum.paragraphs(rand(1..4)).join("\n"))
  rand(3..5).times do
    p.comments.create(body: Faker::HipsterIpsum.paragraphs(rand(1..3)).join("\n"), user_id: USERS.sample.id)
  end
  rand(0..1).times do
    p.comments.create(body: 'This comment is inappropriate and will be removed.', user_id: a.id)
  end
end

puts 'Seed finished'

puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"