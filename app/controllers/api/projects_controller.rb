class Api::ProjectsController < Api::ApplicationController

  def index
    @projects = current_user.projects
    render  'api/projects/index'
  end

  def create
    project      = Project.new(project_params)
    project.user = current_user

    if project.save
      render json: project, status: 200
    else
      render nothing: true, status: 400
    end

  end

  def update
    project = Project.find_by_id(params[:id])

    if project
      project.update_attributes(project_params)
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end

  def destroy
    project = Project.where(id: params[:id], user_id: current_user.id)

    if project
      project.first.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end

  end

private

  def project_params
    params.require(:project).permit(
      :name
    )
  end

end