require 'faker'

FactoryGirl.define do
  factory :comment do
    association :task
    body { Faker::Lorem.sentence(1) }
  end
end