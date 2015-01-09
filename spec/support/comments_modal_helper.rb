module CommentsModalHelper
  def open_comments_modal
    visit '/todo/projects'
    page.find('.task').hover
    page.find('.glyphicon-comment').click
  end
end