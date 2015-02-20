FactoryGirl.define do
  factory :player do

    trait :first do
      firstname "First"
      lastname "First"
    end

    trait :second do
      firstname "Second"
      lastname "Second"
    end

    trait :third do
      firstname "Third"
      lastname "Third"
    end

    trait :fourth do
      firstname "Fourth"
      lastname "Fourth"
    end

    trait :without_lastname do
      firstname "String"
    end

    firstname "asd"
    date_of_birth "2014-12-15"
    email "email@email"
    phone_number 1
    max_break 20
    city "City Name"
  end

end
