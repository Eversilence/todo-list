require "rails_helper"

describe Comment do

  context 'Associations' do
    it { should have_many(:attachments).dependent(:destroy) }
    it { should belong_to(:task) }
  end

  context 'Validations' do
    it { should validate_presence_of(:task_id) }
    it { should ensure_length_of(:body).is_at_least(2) }
    it { should ensure_length_of(:body).is_at_most(60) }
  end

end
