require "rails_helper"
require "spec_helper"

describe "Project CRUD", :js => true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end
  let(:project_name) { Faker::Lorem.words(3).join(' ') }

  it "should create project" do
    visit '/todo/projects'
    page.find(".add-project").click
    fill_in 'name', :with => project_name
    click_button('Add new project')
    expect(page).to have_content (project_name)
  end

  it "should update project" do
    FactoryGirl.create(:project, user: @user)
    visit '/todo/projects'
    page.find('.project').hover
    page.find('.glyphicon-pencil').click
    fill_in 'name', :with => 'Updated project name'
    click_button('Save')
    expect(page).to have_content ('Updated project name')
  end

  it "should delete project" do
    FactoryGirl.create(:project, name: 'To be deleted', user: @user)
    visit '/todo/projects'
    page.save_screenshot('delete.jpg')
    page.find('.project').hover
    page.find('.glyphicon-trash').click
    expect(page).to have_no_content('To be deleted')
  end

end