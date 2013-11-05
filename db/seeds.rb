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
  p.update_attribute(:created_at, Time.now - rand(600..31536000))
 
  rand(3..5).times do
    p.comments.create(body: Faker::HipsterIpsum.paragraphs(rand(1..3)).join("\n"), user_id: USERS.sample.id)
  end
  rand(0..1).times do
    p.comments.create(body: 'This comment is inappropriate and will be removed!', user_id: a.id)
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