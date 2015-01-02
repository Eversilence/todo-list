require "rails_helper"

describe Task do
  it 'is valid with a name and a project' do
    expect(build(:task)).to be_valid
  end

  it 'is invalid without a name' do
    task = build(:task, name: nil)
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a project' do
    task = build(:task, project: nil)
    task.valid?
    expect(task.errors[:project_id]).to include("can't be blank")
  end

  it 'is invalid if name is shorter than 5 characters' do
    task = build(:task, name: Faker::Lorem.characters(1..4))
    task.valid?
    expect(task.errors[:name]).to include("is too short (minimum is 5 characters)")
  end

  it 'is invalid if name is longer than 60 characters' do
    task = build(:task, name: Faker::Lorem.characters(61))
    task.valid?
    expect(task.errors[:name]).to include("is too long (maximum is 60 characters)")
  end

  it "is invalid with a duplicate name if it belongs to the same project" do
    project = create(:project)
    create(:task, name: 'duplicate name', project: project)
    task = build(:task, name: 'duplicate name', project: project)
    task.valid?
    expect(task.errors[:name]).to include("has already been taken")
  end

  it "is valid with a duplicate name if it doesn't belong to the same project" do
    create(:task, name: 'duplicate name')
    task = build(:task, name: 'duplicate name')
    expect(task).to be_valid
  end

end