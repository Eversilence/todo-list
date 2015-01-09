require "rails_helper"
require "spec_helper"

describe "sign in process", :js => true do
  let(:email)    { Faker::Internet.email}
  let(:password) { Faker::Internet.password(8) }

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
    create(:user, email: 'irdis.evale@gmail.com', password: '7214661e')
    fill_in 'Email', :with => 'irdis.evale@gmail.com'
    fill_in 'Password', :with => '7214661e'
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end

end