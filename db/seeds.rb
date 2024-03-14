# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

100.times do |n|
  User.create!(
    name: "seedテスト#{n + 1}",
    email: "seed#{n + 1}@test.com",
    password: "test",
    password_confirmation: "test"
    )
end

User.all.each do |user|
  user.create_wish_list!(title: "#{user.name}のバケットリスト")
end
