class Api::AttachmentsController < Api::ApplicationController

  def index
    @attachments = Attachment.where(comment_id: params[:comment_id])
  end

  def create
    comment = Comment.find_by_id(params[:comment_id])
    comment.attachments << Attachment.create(file: params[:file])
    render nothing: true, status: 200
  end

  def destroy
    attachment = Attachment.find_by_id(params[:id])
    if attachment
      attachment.remove_file!
      attachment.save
      attachment.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end


end