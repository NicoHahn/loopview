class ConcreteIssueTemplatesController < ApplicationController

  before_action :set_concrete_issue_template, only: [:edit, :update, :destroy]

  def index
    @templates = IssueTemplate.all
  end

  def new
    @concrete_issue_template = ConcreteIssueTemplate.new
    @issue_template = IssueTemplate.find_by(id: params[:issue_template_id])
    @predefined_attributes = @issue_template.issue_template_attributes
    @predefined_attributes.each { |p| @concrete_issue_template.concrete_template_values.build(issue_template_attribute_id: p.id, concrete_issue_template: @concrete_issue_template.id) }
  end

  def create
    @concrete_issue_template = ConcreteIssueTemplate.create!(params.require(:concrete_issue_template).permit(:project_id, :issue_template_id, concrete_template_values_attributes: [:issue_template_attribute_id, :concrete_issue_template_id, :extended_field_value]))
    if @concrete_issue_template
      redirect_to edit_concrete_issue_template_path(id: @concrete_issue_template.id)
    end
  end

  def edit
    @predefined_attributes = @concrete_issue_template.issue_template.issue_template_attributes
    @issue_template = @concrete_issue_template.issue_template
  end

  def update
  end

  def destroy
    @concrete_issue_template.destroy!
  end

  private

  def set_concrete_issue_template
    @concrete_issue_template = ConcreteIssueTemplate.find_by!(id: params[:id])
  end

end
