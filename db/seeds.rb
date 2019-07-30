User.create(
  name: "Admin",
  email: "admin123456@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true
)

5.times do |i|
  User.create([{
    name: Faker::Name.name,
    email: Faker::Internet.email,
    #remote_avatar_url: "https://randomuser.me/api/portraits/#{["men", "women"].sample}/#{i}.jpg",
    #password: Faker::Internet.password
  }])
end

name_district = ["Ho Hoan Kiem", "Hai Ba Trung", "Hoang Mai", "Tay Bac"]

name_district.each do |name|
  District.create!(name: name)
end
