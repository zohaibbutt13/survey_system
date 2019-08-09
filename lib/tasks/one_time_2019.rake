require 'date'

desc 'To create trial package'
task add_packages: :environment do
  SubscriptionPackage.create(subscription_package_name: 'Platinum',
                         max_supervisors: 100, max_members: 1000)
  SubscriptionPackage.create(subscription_package_name: 'Gold',
                         max_supervisors: 50, max_members: 500)
  SubscriptionPackage.create(subscription_package_name: 'Silver',
                         max_supervisors: 20, max_members: 200)
  SubscriptionPackage.create(subscription_package_name: 'Trial',
                             max_supervisors: 100, max_members: 1000)
end

desc 'To create surveys'
task add_surveys: :environment do
  surveys_list = [
    ['public', 'Customer', 'Customer feedback survey', 'feedback',
     DateTime.new(2019, 7, 26), 1, 1],
    ['private', 'Leader', 'New lead selection survey', 'lead',
     DateTime.new(2019, 7, 27), 1, 1],
    ['private', 'Party', 'Party attendants survey', 'attend',
     DateTime.new(2019, 8, 5), 1, 1],
    ['public', 'Restaurant', 'feedback survey', 'feedback',
     DateTime.new(2019, 8, 6), 1, 1]
  ]
  # Creating surveys
  surveys_list.each do |type, name, description, category, expiry, user_id, company_id|
    Survey.create(survey_type: type, name: name, description: description,
                  category: category, expiry: expiry, user_id: user_id, company_id: company_id)
  end
end

# Create user responses for survey having id 1
# TODO: Replace the survey id according to the survey for creating its responses
desc 'Create User Responses'
task add_user_responses: :environment do
  UserResponse.create(user_id: 1, survey_id: 10, email: 'user1@abc.com', company_id: 1)
  UserResponse.create(user_id: 1, survey_id: 10, email: 'user2@abc.com', company_id: 1)
  UserResponse.create(user_id: 1, survey_id: 10, email: 'user3@abc.com', company_id: 1)
  UserResponse.create(user_id: 1, survey_id: 10, email: 'user4@abc.com', company_id: 1)
end

# Create answers for above created user respones
# TODO: Make sure you already have questions & options associated with a survey
desc 'Create Answers'
task add_answers: :environment do
  Answer.create(user_response_id: 9, question_id: 16, option_id: 34)
  Answer.create(user_response_id: 9, question_id: 17, option_id: 37)
  Answer.create(user_response_id: 9, question_id: 17, option_id: 38)
  Answer.create(user_response_id: 9, question_id: 18, option_id: 42)
  Answer.create(user_response_id: 9, question_id: 19, detail: 'user1')
  Answer.create(user_response_id: 10, question_id: 16, option_id: 34)
  Answer.create(user_response_id: 10, question_id: 17, option_id: 37)
  Answer.create(user_response_id: 10, question_id: 17, option_id: 39)
  Answer.create(user_response_id: 10, question_id: 18, option_id: 42)
  Answer.create(user_response_id: 10, question_id: 19, detail: 'user2')
  Answer.create(user_response_id: 11, question_id: 16, option_id: 35)
  Answer.create(user_response_id: 11, question_id: 17, option_id: 37)
  Answer.create(user_response_id: 11, question_id: 17, option_id: 40)
  Answer.create(user_response_id: 11, question_id: 18, option_id: 42)
  Answer.create(user_response_id: 11, question_id: 19, detail: 'user3')
  Answer.create(user_response_id: 12, question_id: 16, option_id: 36)
  Answer.create(user_response_id: 12, question_id: 17, option_id: 41)
  Answer.create(user_response_id: 12, question_id: 17, option_id: 39)
  Answer.create(user_response_id: 12, question_id: 18, option_id: 43)
  Answer.create(user_response_id: 12, question_id: 19, detail: 'user4')
end