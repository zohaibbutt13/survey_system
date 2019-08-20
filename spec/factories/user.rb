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
    subdomain { "7vals" }
    subscription_package_id { 1 }
  end

  factory :group, class: Group do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
  end

  factory :subscription_package, class: SubscriptionPackage do
    id { 1 }
    subscription_package_name { "Trial" }
    max_supervisors { 100 }
    max_members { 1000 }
  end

  factory :company_setting, class: CompanySetting do
    id { 1 }
    max_questions { 100 }
    supervisors_survey_permission { true }
    supervisors_settings_permission { true }
    members_settings_permission { true }
    survey_expiry_days { 5 }
  end

  factory :user_setting, class: UserSetting do
    id { 1 }
    show_graphs { true }
    show_history { true }
  end
end