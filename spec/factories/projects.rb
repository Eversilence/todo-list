require 'faker'

FactoryGirl.define do
  factory :project do
    association :user
    name { Faker::Lorem.words(3).join (' ') }
  end
end