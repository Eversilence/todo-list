require "rails_helper"

describe Project do
  it "is valid with a name and a user" do
    expect(build(:project)).to be_valid
  end

  it "is invalid without a name" do
    project = build(:project, name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a user" do
    project = build(:project, user: nil)
    project.valid?
    expect(project.errors[:user_id]).to include("can't be blank")
  end

  it "is valid with a duplicate name if it has different user" do
    create(:project, name: 'duplicate name')
    project = build(:project, name: 'duplicate name')
    expect(project).to be_valid
  end

  it 'is invalid if name is longer than 60 characters' do
    project = build(:project, name: Faker::Lorem.characters(61))
    project.valid?
    expect(project.errors[:name]).to include("is too long (maximum is 60 characters)")
  end

  it 'is invalid if name is shorter than 5 characters' do
    project = build(:project, name: Faker::Lorem.characters(4))
    project.valid?
    expect(project.errors[:name]).to include("is too short (minimum is 5 characters)")
  end

  it "is invalid with a duplicate name if it has the same user" do
    user = create(:user)
    create(:project, name: 'duplicate name', user_id: user.id)
    project = build(:project, name: 'duplicate name', user_id: user.id)
    project.valid?
    expect(project.errors[:name]).to include("has already been taken")
  end

end