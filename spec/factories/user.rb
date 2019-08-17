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
  end

  factory :group, class: Group do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
  end

  factory :activity, class: Activity do
    action { 'created' }
    owner_id { 1 }
    trackable_id { Faker::Number.digit }
    trackable_type { 'Survey' }
    company_id { 1 }
  end

  factory :admin_user, class: User do
    id { 7 }
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    email       { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
    role { 'admin' }
    company_id { 1 }
  end

  factory :supervisor_user, class: User do
    id { 1 }
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    email       { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
    role { 'supervisor' }
    company_id { 1 }
  end
end
