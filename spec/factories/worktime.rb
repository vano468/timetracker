FactoryGirl.define do
  factory :worktime do
    date_from Faker::Time.between(3.hours.ago, Time.now, :morning)
    date_to   Faker::Time.between(3.hours.ago, Time.now, :night)
    user
  end
end