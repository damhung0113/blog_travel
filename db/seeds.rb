# User.create(
#   name: "Admin",
#   email: "admin@blogtravel.com",
#   password: "123456",
#   password_confirmation: "123456",
#   is_admin: true
# )

# 30.times do |i|
#   User.create([{
#     name: Faker::Name.name,
#     email: Faker::Internet.email,
#     remote_avatar_url: "https://randomuser.me/api/portraits/#{["men", "women"].sample}/#{i}.jpg",
#     password: Faker::Internet.password
#   }])
# end

# name_district = ["Hoan Kiem", "Hai Ba Trung", "Hoang Mai", "Tay Ho", "Long Bien", "Ha Dong", "Bac Tu Liem", "Nam Tu Liem"]

# name_district.each do |name|
#   District.create!(name: name)
# end

# 10.times do
#   Blog.create([{
#       user_id: Faker::Number.between(from: User.first.id, to: User.last.id),
#       district_id: Faker::Number.between(from: District.first.id, to: District.last.id),
#       remote_cover_photo_url: "https://loremflickr.com/800/500/travel",
#       topic: Faker::Nation.nationality,
#       address: Faker::Address.street_address,
#       content: Faker::Markdown.emphasis
#       }])
# end

# 10.times do
#   Place.create([{
#     name: Faker::Nation.capital_city,
#     description: Faker::Dessert.flavor,
#     address: Faker::Address.street_address,
#     vote: Faker::Number.between(from: 1, to: 5),
#     cost: (Faker::Number.between(from: 1, to: 5)*100).to_s,
#     district_id: Faker::Number.between(from: District.first.id, to: District.last.id),
#     remote_photo_url: "https://loremflickr.com/800/500/city",
#     status: ["hotel", "restaurant"].sample,
#   }])
# end

# 10.times do
#   Relationship.create(
#     follower_id: Faker::Number.between(from: User.first.id, to: User.last.id),
#     followed_id: Faker::Number.between(from: User.first.id, to: User.last.id),
#   )
# end

# 50.times do
#   Like.create(
#     user_id: Faker::Number.between(from: User.first.id, to: User.last.id),
#     blog_id: Blog.last.id,
#   )
# end
