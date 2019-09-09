FactoryBot.define do
  factory :recipe do
    sequence :title do |n|
      "Generic Recipe #{n}"
    end
    difficulty { "Generic" }
    cook_time { 10 }
    ingredients { "Ingredients" }
    cook_method { "Method" }
    recipe_type
    user
    cuisine
  end
end
