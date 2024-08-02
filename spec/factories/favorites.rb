FactoryBot.define do
  factory :favorite do
    association :wish_list
    user { wish_list.user }
  end
end
