require "rails_helper"
require "spec_helper"

describe "sign in process", :js => true do
  let!(:email)    { Faker::Internet.email}
  let!(:password) { Faker::Internet.password(8) }

  it "signs me up" do
    visit '/users/sign_up'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    fill_in 'Password confirmation', :with => password
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
  end

  it "signs me in" do
    visit '/users/sign_in'
    create(:user, email: email, password: password)
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end

end