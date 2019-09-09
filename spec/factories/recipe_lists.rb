FactoryBot.define do
  factory :recipe_list do
    user
    sequence :name do |n|
      "Generic List#{n}"
    end
  end
end
