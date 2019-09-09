FactoryBot.define do
  factory :recipe_type, class: RecipeType  do
    sequence :name do |n|
      "Generic Type#{n}"
    end
  end
end
