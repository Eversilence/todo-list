include CommentsModalHelper
require "rails_helper"
require "spec_helper"

describe "Attachment CRUD", :js => true do
  let!(:user)    { create(:user) }
  let!(:project) { create(:project, user: user) }
  let!(:task)    { create(:task, project: project) }
  let (:file)    { File.join(Rails.root, '/spec/factories/awesome.svg.png') }

  before do
    sign_in(user)
    Capybara.current_driver = :selenium
  end

  it "should upload file with a comment" do
    open_comments_modal
    page.execute_script("$('.file-upload').removeClass('file-upload')")
    fill_in 'comment_body', with: Faker::Lorem.words(3).join(' ')
    attach_file('multi_upload', file)
    click_button('Comment')
    page.find('.glyphicon-paperclip').click
    expect(page).to have_content ('New comment successfuly added')
    expect(page).to have_content ('awesome.svg.png')
  end

  it "should clear file upload queue" do
    open_comments_modal
    page.execute_script("$('.file-upload').removeClass('file-upload')")
    attach_file('multi_upload', file)
    page.find('.clear').click
    expect(page).to have_no_content ('awesome.svg.png')
  end

  it "should upload file for existing comment" do
    comment = create(:comment, task: task)
    open_comments_modal
    page.execute_script("$('.file-upload').removeClass('file-upload')")
    page.find('.glyphicon-paperclip').click
    attach_file('multi_upload', file)
    expect(page).to have_content('awesome.svg.png')
  end

  it "should delete uploaded attachment" do
    comment = create(:comment, task: task)
    create(:attachment, comment: comment)
    open_comments_modal
    page.execute_script("$('.file-upload').removeClass('file-upload')")
    within('.comment') do
      page.find('.glyphicon-paperclip').click
      within('.attachment') { page.find('.glyphicon-trash').click }
    end
    expect(page).to have_no_content ('awesome.svg.png')
  end

end