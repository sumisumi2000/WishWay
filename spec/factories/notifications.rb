FactoryBot.define do
  factory :notification do
    is_required { false }
    association :user
  end
end
