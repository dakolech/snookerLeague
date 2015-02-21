FactoryGirl.define do
  factory :break do
    trait :update do
      points 67
    end

    trait :create do
      player_id 1
      frame_id 1
      points 0
    end
  end

end
