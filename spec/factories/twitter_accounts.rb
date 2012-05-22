FactoryGirl.define do
  factory :twitter_account do
    sequence(:nickname) { |n| "displayname#{n}"}
    last_status_id "1"
  end
end
