require 'date'

desc 'To create packages'
task add_packages: :environment do
  SubscriptionPackage.create(package_name: 'Platinum',
                             max_supervisors: 100, max_members: 1000)
  SubscriptionPackage.create(package_name: 'Golden',
                             max_supervisors: 50, max_members: 500)
  SubscriptionPackage.create(package_name: 'Silver',
                             max_supervisors: 20, max_members: 200)
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

# Create user responses against survey with id 21
# TODO: Replace the survey id according to the survey for creating its responses
desc 'Create User Responses'
task add_user_responses: :environment do
  UserResponse.create(users_id: 1, surveys_id: 21, email: 'user1@abc.com')
  UserResponse.create(users_id: 2, surveys_id: 21, email: 'user2@abc.com')
  UserResponse.create(users_id: 3, surveys_id: 21, email: 'user3@abc.com')
  UserResponse.create(users_id: 4, surveys_id: 21, email: 'user4@abc.com')
end

# Create answers for above created user respones
# TODO: Make sure you already have questions & options associated with a survey
desc 'Create Answers'
task add_answers: :environment do
  Answer.create(user_response_id: 1, question_id: 1, option_id: 1)
  Answer.create(user_response_id: 1, question_id: 2, option_id: 4)
  Answer.create(user_response_id: 1, question_id: 2, option_id: 5)
  Answer.create(user_response_id: 1, question_id: 3, option_id: 9)
  Answer.create(user_response_id: 1, question_id: 4, detail: 'user1')
  Answer.create(user_response_id: 2, question_id: 1, option_id: 1)
  Answer.create(user_response_id: 2, question_id: 2, option_id: 4)
  Answer.create(user_response_id: 2, question_id: 2, option_id: 6)
  Answer.create(user_response_id: 2, question_id: 3, option_id: 9)
  Answer.create(user_response_id: 2, question_id: 4, detail: 'user2')
  Answer.create(user_response_id: 3, question_id: 1, option_id: 2)
  Answer.create(user_response_id: 3, question_id: 2, option_id: 4)
  Answer.create(user_response_id: 3, question_id: 2, option_id: 7)
  Answer.create(user_response_id: 3, question_id: 3, option_id: 9)
  Answer.create(user_response_id: 3, question_id: 4, detail: 'user3')
  Answer.create(user_response_id: 4, question_id: 1, option_id: 3)
  Answer.create(user_response_id: 4, question_id: 2, option_id: 8)
  Answer.create(user_response_id: 4, question_id: 2, option_id: 6)
  Answer.create(user_response_id: 4, question_id: 3, option_id: 10)
  Answer.create(user_response_id: 4, question_id: 4, detail: 'user4')
end
