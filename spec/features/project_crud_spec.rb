require "rails_helper"
require "spec_helper"

describe "Project CRUD", :js => true do
  let!(:user)         { create(:user) }
  let (:project_name) { Faker::Lorem.words(3).join(' ') }

  before do
    sign_in(user)
  end

  it "should create project" do
    visit '/todo/projects'
    page.find(".add-project").click
    fill_in 'name', :with => project_name
    click_button('Add new project')
    expect(page).to have_content (project_name)
  end

  it "should update project" do
    create(:project, user: user)

    visit '/todo/projects'
    page.find('.project').hover
    page.find('.glyphicon-pencil').click
    fill_in 'name', :with => 'Updated project name'
    click_button('Save')
    expect(page).to have_content ('Updated project name')
  end

  it "should delete project" do
    create(:project, name: 'To be deleted', user: user)

    visit '/todo/projects'
    page.find('.project').hover
    page.find('.glyphicon-trash').click
    expect(page).to have_no_content('To be deleted')
  end

end