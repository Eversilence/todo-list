require "rails_helper"

describe Project do

  context 'Associations' do
    it { should have_many(:tasks).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  context 'Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    it { should ensure_length_of(:name).is_at_least(5) }
    it { should ensure_length_of(:name).is_at_most(60) }
  end

end
