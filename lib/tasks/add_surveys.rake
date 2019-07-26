require 'date'

task add_surveys: :environment do
  surveys_list = [
    ['feedback', 'Customer feedback survey', 'feedback',
     DateTime.new(2019, 7, 26), 4],
    ['voting', 'New lead selection survey', 'votes',
     DateTime.new(2019, 7, 27), 4],
    ['attendants', 'Party attendants survey', 'party',
     DateTime.new(2019, 7, 30), 4],
    ['cafe', 'Cafe feedback survey', 'food',
     DateTime.new(2019, 8, 1), 4]
  ]
  # Adding surveys
  surveys_list.each do |name, description, category, expiry, user_id|
    Survey.create(name: name, description: description, category: category,
                  expiry: expiry, user_id: user_id)
  end
  puts 'Surveys added'
end
