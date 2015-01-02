require 'faker'

FactoryGirl.define do
  factory :task do
    association :project
    name { "#{Faker::Hacker.verb} #{Faker::Hacker.noun}" }
  end
end