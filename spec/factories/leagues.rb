FactoryGirl.define do
  factory :league do

    trait :my_string do
      name "My String"
    end

    trait :second_league do
      name "Second league".titleize
    end

    start_date "2014-12-14"
    end_date "2014-12-16"
    number_of_players 10
    number_of_winners 1
    number_of_dropots 1
    best_of 3
    win_points 3
    loss_points 0
  end

end
