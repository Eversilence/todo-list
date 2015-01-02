require "rails_helper"

describe Task do

  context 'Associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should belong_to(:project) }
  end

  context 'Validations' do
    it { should validate_presence_of(:project_id) }
    it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
    it { should ensure_length_of(:name).is_at_least(5) }
    it { should ensure_length_of(:name).is_at_most(60) }

    # write a proper validation for the deadline!
    # it { should_not allow_value('just_a_string').for(:deadline) }
    it { should allow_value(Faker::Date.forward).for(:deadline) }
    it { should allow_value('01.06.1991').for(:deadline)}
  end

end
