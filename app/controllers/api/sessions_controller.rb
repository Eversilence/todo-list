class Api::SessionsController < Api::ApplicationController

  def current_user_info
    @user = current_user || User.new
    render  'api/users/show'
  end


end