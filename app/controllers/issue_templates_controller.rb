class IssueTemplatesController < ApplicationController
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
  end

  def destroy
  end

  def add_attribute
    if params[:id].blank?
      issue_template = IssueTemplate.create(title: params[:title])
      IssueTemplateAttribute.create(issue_template_id: issue_template.id, attribute_type: params[:attribute_id].to_i)
      render json: {location: "/issue_templates/#{issue_template.id}/edit"}
    end
  end

end
