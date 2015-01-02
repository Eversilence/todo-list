require 'faker'

FactoryGirl.define do
  factory :project do
    association :user
    name { Faker::Lorem.words(2).join (' ') }
  end
end