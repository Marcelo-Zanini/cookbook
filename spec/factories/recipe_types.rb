FactoryBot.define do
  factory :recipe_type do
    sequence :name do |n|
      "Generic Type#{n}"
    end
  end
end
