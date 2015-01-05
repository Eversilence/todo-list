require 'faker'

FactoryGirl.define do
  factory :attachment do
    association :comment
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/factories/awesome.svg.png')))
  end
end