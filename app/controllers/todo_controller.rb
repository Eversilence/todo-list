class TodoController < ApplicationController
  before_action :authenticate_user!, only: [:projects]

  def home
  end

  def projects
  end
end
