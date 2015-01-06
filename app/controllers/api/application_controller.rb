class Api::ApplicationController < ActionController::Base
respond_to :json

rescue_from ActiveRecord::RecordNotFound,       with: :record_not_found
rescue_from ActionController::ParameterMissing, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid,        with: :record_invalid
rescue_from CanCan::AccessDenied,               with: :access_denied

  private

  def record_not_found
    render nothing: true, status: 400
  end

  def record_invalid
    render nothing: true, status: 400
  end

  def access_denied
    render nothing: true, status: 403
  end

end