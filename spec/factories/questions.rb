FactoryBot.define do
  factory :question do
    name { 'Q1. Do you eat the RDA of fruit and vegetables?' }

    trait :q1 do
      name { 'Q1.' }
    end

    trait :q2 do
      name { 'Q2.' }
    end

    trait :q3 do
      name { 'Q3.' }
    end
  end
end
