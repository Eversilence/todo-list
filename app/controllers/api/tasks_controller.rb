class Api::TasksController < Api::ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project

  def index
  end

  def create
    render json: @task, status: 200 if @task.save
  end

  def update
    @task.update_attributes(task_params)
    render nothing: true, status: 200
  end

  def destroy
    @task.destroy
    render nothing: true, status: 200
  end


private

  def task_params
    params.require(:task).permit(
      :name,
      :completed,
      :deadline,
      :position
    )
  end

end