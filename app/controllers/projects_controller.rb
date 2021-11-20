class ProjectsController < ApplicationController

  before_action :set_project, except: [:new, :create, :index]


  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show

  end

  def create
    project_id, project_title, existing = JiraConnector.check_for_project(params[:project][:external_key], current_user)
    if Project.find_by(external_id: project_id, external_key: params[:project][:external_key]).nil? && existing
      params[:project][:external_id] = project_id
      params[:project][:external_title] = project_title
      @project = Project.create(params.require(:project).permit(:external_key, :external_title, :external_id))
      if @project
        redirect_to edit_project_path(id: @project.id)
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_project
    @porject = Project.find_by!(id: params[:id]) unless params[:id].blank?
  end

end
