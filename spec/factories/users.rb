FactoryBot.define do
  factory :user do
    password { "password" }
    password_confirmation { "password" }
    email { "sumisumi@gmail.com" }
    name { "すみ" }
  end
end
