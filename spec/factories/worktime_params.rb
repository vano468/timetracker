FactoryGirl.define do
  factory :worktime_params, class: Hash do
    day       DateTime.yesterday.strftime '%Y-%m-%d'
    time_from Faker::Time.between(3.hours.ago, Time.now, :morning).strftime('%H:%M')
    time_to   Faker::Time.between(3.hours.ago, Time.now, :night).strftime('%H:%M')
    message   ''

    initialize_with { attributes }
  end
end