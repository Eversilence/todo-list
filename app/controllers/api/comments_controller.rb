class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task

  def index
  end

  def create
    render json: @comment, status: 200 if @comment.save
  end

  def update
    @comment.update_attributes(comment_params)
    render nothing: true, status: 200
  end

  def destroy
    @comment.destroy
    render nothing:true, status: 200
  end


private

  def comment_params
    params.require(:comment).permit(
      :body
    )
  end

end