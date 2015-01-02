require "rails_helper"

describe User do

  context 'DB' do
    it { should have_db_index(:email).unique(true) }
    it { should have_db_index(:reset_password_token).unique(true) }
  end

  context 'Associations' do
    it { should have_many(:projects).dependent(:destroy) }
  end

  context 'Validations' do
    it { should validate_presence_of(:email) }
    it { should ensure_length_of(:password).is_at_least(8) }
    it { should_not allow_value(Faker::Internet.domain_name).for(:email) }
    it { should allow_value(Faker::Internet::email).for(:email) }
  end

end
