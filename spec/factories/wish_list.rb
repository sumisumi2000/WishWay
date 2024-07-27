FactoryBot .define do
  factory :wish_list do
    title { "バケットリスト" }
    is_public { true }
    granted_wish_rate { 50 }
    association :user
  end
end
