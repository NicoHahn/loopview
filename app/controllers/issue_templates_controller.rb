class IssueTemplatesController < ApplicationController

  before_action :set_issue_template, except: [:new, :create, :index]

  def index
    @templates = IssueTemplate.all
  end

  def new
    @issue_template = IssueTemplate.new
  end

  def create
  end

  def edit

  end

  def update
    if @issue_template.update(params.require(:issue_template).permit(:title, issue_template_attributes_attributes: [:field_title, :field_value, :id]))
      render json: {success: true}
    end
  end

  def destroy
    @issue_template.destroy!
    redirect_to issue_templates_path
  end

  def add_attribute
    if params[:id].blank?
      @issue_template = IssueTemplate.create(title: params[:title])
    end
    IssueTemplateAttribute.create(issue_template_id: @issue_template.id, attribute_type: params[:attribute_id].to_i)
    render json: {location: "/issue_templates/#{@issue_template.id}/edit"}
  end

  private

  def set_issue_template
    @issue_template = IssueTemplate.find_by!(id: params[:id]) unless params[:id].blank?
  end

end
