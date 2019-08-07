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
end