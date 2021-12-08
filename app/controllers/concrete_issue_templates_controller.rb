class ConcreteIssueTemplatesController < ApplicationController

  before_action :set_concrete_issue_template, only: [:edit, :update, :destroy, :show, :send_to_jira]

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
    @concrete_issue_template = ConcreteIssueTemplate.create!(params.require(:concrete_issue_template).permit(
      :project_id, :issue_template_id, concrete_template_values_attributes: [:issue_template_attribute_id, :concrete_issue_template_id, :extended_field_value, dynamic_size_data: {}]))
    if @concrete_issue_template
      redirect_to edit_concrete_issue_template_path(id: @concrete_issue_template.id), success: "Erfolgreich erstellt!"
    end
  end

  def edit
    @predefined_attributes = @concrete_issue_template.issue_template.issue_template_attributes
    @issue_template = @concrete_issue_template.issue_template
  end

  def show
    @predefined_attributes = @concrete_issue_template.issue_template.issue_template_attributes
    @issue_template = @concrete_issue_template.issue_template
  end

  def update
    if @concrete_issue_template.update(params.require(:concrete_issue_template).permit(concrete_template_values_attributes: [:issue_template_attribute_id, :extended_field_value, :id]))
      redirect_to edit_concrete_issue_template_path(id: @concrete_issue_template.id), success: "Erfolgreich gespeichert!"
    else
      redirect_to edit_concrete_issue_template_path(id: @concrete_issue_template.id), danger: "Es ist ein Fehler aufgetreten!"
    end
  end

  def destroy
    @concrete_issue_template.destroy!
    redirect_to projects_path(id: @concrete_issue_template.project_id), success: "Ticket erfolgreich gelöscht!"
  end

  def send_to_jira
    response = JiraConnector.send_request(:post, "https://loopview.atlassian.net/rest/api/3/issue", current_user, nil, @concrete_issue_template)
    if response.code.to_i == 201
      response_body = JSON.parse(response.body)
      ConcreteIssueTemplate.find_by!(id: params[:id]).connect_with_issue(response_body["id"])
      redirect_to concrete_issue_template_path(id: @concrete_issue_template), success: "Ticket erfolgreich erstellt!"
    else
      redirect_to concrete_issue_template_path(id: @concrete_issue_template), danger: "Es ist ein Fehler aufgetreten. Das Ticket konnte somit nicht erstellt werden!"
    end
  end

  private

  def set_concrete_issue_template
    @concrete_issue_template = ConcreteIssueTemplate.find_by!(id: params[:id])
  end

end
