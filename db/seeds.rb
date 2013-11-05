require 'ffaker'

User.delete_all
Post.delete_all
Comment.delete_all
Topic.delete_all

module SeedMethods
  def skip_confirm
    skip_confirmation!
    save!
  end

  def set_random_created_at
    update_attribute(:created_at, Time.now - rand(600..31536000))
  end
end

class User
  include SeedMethods
end

class Post
  include SeedMethods
end

class Comment
  include SeedMethods
end

u = User.new(username: 'blawkitter', email: 'guy@email.com', password: 'password')
u.skip_confirm
u.update_attributes(role: 'moderator')

u2 = User.new(username: 'kittblawker', email: 'othaguy@email.com', password: 'password')
u2.skip_confirm

me = User.new(username: 'beaugaines', email: 'beaugaines@yahoo.com', password: 'password')
me.skip_confirm
u.update_attributes(role: 'admin')

a = User.new(username: 'admin', email: 'admin@blawkit.com', password: 'password')
a.skip_confirm
u.update_attributes(role: 'admin')

users = [u, u2, me]

# hipster topics
topics = []
15.times do
  topics << Topic.create(
    name: Faker::HipsterIpsum.words(rand(1..5)).join(" ").titleize,
    description: Faker::HipsterIpsum.paragraphs(rand(1..3)).join("\n")
  )
end


rand(30..50).times do
  topic = topics.sample
  user = users.sample
  p = user.posts.create(title: Faker::HipsterIpsum.words(rand(1..10)).join(" ").titleize,
    body: Faker::HipsterIpsum.paragraphs(rand(1..4)).join("\n"),
    topic: topic)
  p.set_random_created_at
 
  rand(3..5).times do
    c = p.comments.create(body: Faker::HipsterIpsum.paragraphs(rand(1..3)).join("\n"), user: users.sample)
    c.set_random_created_at
  end
  rand(0..1).times do
    c = p.comments.create(body: 'This comment is inappropriate and will be removed!', user: a)
    c.set_random_created_at
  end
end

puts 'Seed finished'

puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"



# rand(4..10).times do
#   password = Faker::Lorem.characters(10)
#   u = User.new(
#     name: Faker::Name.name, 
#     email: Faker::Internet.email, 
#     password: password, 
#     password_confirmation: password)
#   u.skip_confirmation!
#   u.save

#   # Note: by calling `User.new` instead of `create`,
#   # we create an instance of a user which isn't saved to the database.
#   # The `skip_confirmation!` method sets the confirmation date
#   # to avoid sending an email. The `save` method updates the database.

#   rand(5..12).times do
#     p = u.posts.create(
#       title: Faker::Lorem.words(rand(1..10)).join(" "), 
#       body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
#     # set the created_at to a time within the past year
#     p.update_attribute(:created_at, Time.now - rand(600..31536000))

#     rand(3..7).times do
#       p.comments.create(
#         body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"))
#     end
#   end
# end