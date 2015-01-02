require "rails_helper"

describe Project do
  subject{build(:project, name: name, user: user)}
  let(:name) { 'test name'}
  let(:user) { create(:user) }
  before(:each) { subject.valid? }

  it "is valid with a name and a user" do
    expect(subject).to be_valid
  end

  context "is invalid without a name" do
    let(:name) { nil }
    it{ expect(subject.errors[:name]).to include("can't be blank") }
  end

  context "is invalid without a user" do
    let(:user) { nil }
    it{ expect(subject.errors[:user_id]).to include("can't be blank") }
  end

  context "is invalid if name is longer than 60 characters" do
    let(:name) { Faker::Lorem.characters(61) }
    it{ expect(subject.errors[:name]).to include("is too long (maximum is 60 characters)") }
  end

  context "is invalid if name is shorter than 5 characters" do
    let(:name) { Faker::Lorem.characters(4) }
    it{ expect(subject.errors[:name]).to include("is too short (minimum is 5 characters)") }
  end

  context "is valid with a duplicate name if it has different user" do
    let(:duplicate_project) { create(:project, name: name) }
    it{ expect(duplicate_project).to be_valid }
  end

  context "is invalid if name is shorter than 5 characters" do
    let(:name) { Faker::Lorem.characters(4) }
    it{ expect(subject.errors[:name]).to include("is too short (minimum is 5 characters)") }
  end

  context "is invalid with a duplicate name if it has the same user" do
    let!(:duplicate_project){create(:project, name: name, user: user)}
    before { subject.valid? }
    it{ expect(subject.errors[:name]).to include("has already been taken") }
  end
end