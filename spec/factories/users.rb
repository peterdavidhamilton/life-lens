# NHS Number | Name           | Age | DOB       | Year |
# -----------|------          |-----|----       | ---- |
# 111222333  | DOE, John      | 18  | Jan 14    | 2006 |
# 222333444  | SMITH, Alice   | 25  | Mar 2     | 1999 |
# 333444555  | CARTER, Bob    | 46  | May 20    | 1978 |
# 444555666  | BOND, Charles  | 70  | July 18   | 1954 |
# 555666777  | MAY, Megan     | 14  | Nov 14    | 2010 |
#
FactoryBot.define do
  factory :user do
    nhs_number { '111222333' }
    last_name { 'DOE' }
    dob { "#{Date.today.year - 18}-01-14" }

    trait :miss_match do
      last_name { 'DOO' }
    end

    trait :not_found do
      nhs_number { '123456789' }
      last_name { 'Hamilton' }
      dob { '2024-12-01' }
    end

    trait :ineligible do
      nhs_number { '555666777' }
      last_name { 'MAY' }
      dob { "#{Date.today.year - 14}-11-14" }
    end
  end
end
