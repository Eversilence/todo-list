include CommentsModalHelper
require "rails_helper"
require "spec_helper"

describe "Comment CRUD", :js => true do
  let!(:user)         { create(:user) }
  let!(:project)      { create(:project, user: user) }
  let!(:task)         { create(:task, project: project) }
  let (:comment_body) { Faker::Lorem.words(3).join(' ') }

  before do
    sign_in(user)
  end

  it "should open comments modal view" do
    open_comments_modal
    expect(page).to have_selector('.modal')
  end

  it "should create comment" do
    open_comments_modal
    fill_in 'comment_body', :with => comment_body
    click_button('Comment')
    expect(page).to have_content (comment_body)
  end

  it "should delete comment" do
    create(:comment, body: 'To be deleted', task: task)
    open_comments_modal
    within('.comment') do
      page.find('.glyphicon-trash').click
    end
    expect(page).to have_no_content ('To be deleted')
  end
end