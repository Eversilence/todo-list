class Api::AttachmentsController < Api::ApplicationController
  load_and_authorize_resource :comment
  load_and_authorize_resource :attachment, through: :comment

  def index
  end

  def create
    render 'show', status: 200 if @attachment.save
  end

  def destroy
    @attachment.destroy
    render nothing: true, status: 200
  end

private

  def attachment_params
    params.permit(
      :file,
      :comment_id
    )
  end

end