require 'faker'

FactoryGirl.define do
  factory :user, class: User do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    email       { Faker::Internet.email }
    password { "password"} 
    password_confirmation { "password" }
    confirmed_at { Date.today }
  end

  factory :company, class: Company do
    id { 1 }
    name { Faker::Name.name }
    subdomain { "abc" }
  end

  factory :group, class: Group do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
  end

  factory :survey, class: Survey do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    category { 'Community' }
    survey_type { 'Private' }
    expiry { '2019-08-20' }
  end

  factory :question, class: Question do
    statement { Faker::Name.name }
    question_type { 'Radio Buttons' }
    required  { true }
  end

  factory :option, class: Option do
    detail { Faker::Name.name }
  end

  factory :user_response, class: UserResponse do
    email { Faker::Internet.email }
  end

  factory :answer, class: Answer do
    detail { Faker::Lorem.sentence }
  end
end