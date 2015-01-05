class Api::AttachmentsController < Api::ApplicationController

  def index
    @attachments = Attachment.where(comment_id: params[:comment_id])
  end

  def create
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
      render 'show', status: 200
    else
      render nothing: true, status: 400
    end
  end

  def destroy
    attachment = Attachment.find_by_id(params[:id])

    if attachment
      attachment.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end

private

  def attachment_params
    params.permit(
      :file,
      :comment_id
    )
  end

end