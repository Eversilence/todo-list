require "rails_helper"
require "spec_helper"

describe "Task CRUD", :js => true do
  let!(:user)      { create(:user) }
  let!(:project)   { create(:project, user: user) }
  let (:task_name) { Faker::Lorem.words(3).join(' ') }

  before do
    sign_in(user)
  end

  it "should create task" do
    visit '/todo/projects'
    fill_in 'task_name', :with => task_name
    click_button('Add Task')
    expect(page).to have_content (task_name)
    expect(page).to have_content ('New task successfuly added')
  end

  it "should update task" do
    create(:task, project: project)

    visit '/todo/projects'
    page.find('.task').hover
    within('.task') do
      page.find('.glyphicon-pencil').click
    end
    fill_in 'name', :with => 'Updated task name'
    click_button('Save')
    expect(page).to have_content ('Updated task name')
    expect(page).to have_content ('Task name was successfuly changed')
  end

  it "should delete task" do
    create(:task, name: 'To be deleted', project: project)

    visit '/todo/projects'
    page.find('.task').hover
    within('.task') do
      page.find('.glyphicon-trash').click
    end
    expect(page).to have_no_content('To be deleted')
    expect(page).to have_content('Task was successfuly deleted')
  end

  it "should set task deadline" do
    create(:task, project: project)

    visit '/todo/projects'
    page.find('.task').hover
    within('.task') do
      page.find('.glyphicon-pencil').click
    end
    fill_in 'name', :with => 'Updated task name'
    click_button('Save')
    expect(page).to have_content ('Updated task name')
    expect(page).to have_content ('Task name was successfuly changed')
  end

  it "should mark task as completed" do
    create(:task, project: project)

    visit '/todo/projects'
    page.find('.checkbox-complete').click
    expect(page).to have_content ('Task was successfuly marked as complete')
  end
end