class Api::CommentsController < Api::ApplicationController

  def index
    @comments = Comment.where(task_id: params[:task_id])
  end

  def create
    comment         = Comment.new(comment_params)
    comment.task_id = params[:task_id]

    if comment.save
      render json: comment, status: 200
    else
      render nothing: true, status: 400
    end
  end

  def update
    comment = Comment.find_by_id(params[:id])

    if comment
      comment.update_attributes(comment_params)
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end

  def destroy
    comment = Comment.find_by_id(params[:id])

    if comment
      comment.destroy
      render nothing:true, status: 200
    else
      render nothing:true, status: 400
    end
  end


private

  def comment_params
    params.require(:comment).permit(
      :body
    )
  end

end