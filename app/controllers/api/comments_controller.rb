class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource

  def index
  end

  # before_filter authorize doesn't allow task_id!!11
  def create
    @comment.task_id = params[:task_id]

    if @comment.save
      render json: @comment, status: 200
    else
      render nothing: true, status: 400
    end
  end

  def update
    if @comment
      @comment.update_attributes(comment_params)
      render nothing: true, status: 200
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])

    if @comment
      @comment.destroy
      render nothing:true, status: 200
    end
  end


private

  def comment_params
    params.require(:comment).permit(
      :body
    )
  end

end