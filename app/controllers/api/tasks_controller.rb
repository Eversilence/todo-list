class Api::TasksController < Api::ApplicationController

  def index
    @tasks = Task.where(project_id: params[:project_id])
    render  'api/tasks/index'
  end

  def create
    task            = Task.new(task_params)
    task.project_id = params[:project_id]

    if task.save
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end

  def update
  # not implemented yet
  end

  def destroy
    task = Task.find(params[:id])

    if task
      task.destroy
      render nothing:true, status: 200
    else
      render nothing:true, status: 400
    end
  end


private

  def task_params
    params.require(:task).permit(
      :name,
      :completed,
      :deadline
    )
  end

end