FactoryBot.define do
  factory :cuisine do
    sequence :name do |n|
      "Generic Cusine#{n}"
    end
  end
end
