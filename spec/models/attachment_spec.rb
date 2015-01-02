require "rails_helper"

describe Attachment do

  context 'Associations' do
    it { should belong_to(:comment) }
  end

  context 'Validations' do
    it { should validate_presence_of(:comment_id) }
  end

end