require 'faker'

FactoryGirl.define do
  factory :project do
    association :user
    name { Faker::Lorem.word }
  end
end