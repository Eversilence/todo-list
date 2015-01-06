class Api::ProjectsController < Api::ApplicationController
  load_and_authorize_resource

  def index
  end

  def create
    render json: @project, status: 200 if @project.save
  end

  def update
    @project = Project.find(params[:id])
    authorize! :update, @project

    @project.update_attributes(project_params)
    render nothing: true, status: 200
  end

  def destroy
    @project.destroy
    render nothing: true, status: 200
  end

private

  def project_params
    params.require(:project).permit(
      :name
    )
  end

end