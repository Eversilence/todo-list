require "rails_helper"

describe User do
  it 'is valid with an email and a password' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid if email has not valid format' do
    user = build(:user, email: 'johndoe.com')
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid if password is shorted than 8 characters' do
    user = build(:user, password: Faker::Internet.password(1, 7))
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

end