class IssueTemplatesController < ApplicationController

  before_action :set_issue_template, except: [:new, :create, :index]

  def index
    @templates = IssueTemplate.all
  end

  def new
    @issue_template = IssueTemplate.new
  end

  def create
    @issue_template = IssueTemplate.create(params.require(:issue_template).permit(:title))
    if @issue_template
      redirect_to edit_issue_template_path(id: @issue_template.id), success: "Erfolgreich erstellt!"
    end
  end

  def edit

  end

  def update
    if @issue_template.update(params.require(:issue_template).permit(:title, issue_template_attributes_attributes: [:field_value, :id, :optional_size]))
      redirect_to edit_issue_template_path(id: @issue_template.id), success: "Erfolgreich gespeichert!"
    end
  end

  def destroy
    @issue_template.destroy!
    redirect_to issue_templates_path, success: "Erfolgreich gelöscht!"
  end

  def add_attribute
    if params[:id].blank?
      @issue_template = IssueTemplate.create(title: params[:title])
    end
    IssueTemplateAttribute.create(issue_template_id: @issue_template.id, attribute_type: params[:attribute_type].to_i)
    render json: {id: @issue_template.id, location: "/issue_templates/#{@issue_template.id}/edit"}, success: "Erfolgreich erstellt!"
  end

  private

  def set_issue_template
    @issue_template = IssueTemplate.find_by!(id: params[:id]) unless params[:id].blank?
  end

end
