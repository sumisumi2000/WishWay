FactoryBot.define do
  factory :wish do
    title { 'やりたいこと' }
    granted { false }
    association :wish_list
  end
end
