require 'date'

desc 'To create trial package'
task add_trial_package: :environment do
  SubscriptionPackage.create(subscription_package_name: 'Trial',
                             max_supervisors: 100, max_members: 1000)
end

desc 'To create surveys'
task add_surveys: :environment do
  surveys_list = [
    ['public', 'Customer', 'Customer feedback survey', 'feedback',
     DateTime.new(2019, 7, 26), 4],
    ['private', 'Leader', 'New lead selection survey', 'lead',
     DateTime.new(2019, 7, 27), 4],
    ['private', 'Party', 'Party attendants survey', 'attend',
     DateTime.new(2019, 7, 30), 4],
    ['public', 'Restaurant', 'feedback survey', 'feedback',
     DateTime.new(2019, 8, 1), 4]
  ]
  # Creating surveys
  surveys_list.each do |type, name, description, category, expiry, user_id|
    Survey.create(survey_type: type, name: name, description: description,
                  category: category, expiry: expiry, user_id: user_id)
  end
end