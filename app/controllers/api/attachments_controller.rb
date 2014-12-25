class Api::AttachmentsController < Api::ApplicationController

  def index

  end

  def create
    comment = Comment.find_by_id(params[:comment_id])
    comment.attachments << Attachment.create(file: params[:file])
    render nothing: true, status: 200

  end


end