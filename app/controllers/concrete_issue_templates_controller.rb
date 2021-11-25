class ConcreteIssueTemplatesController < ApplicationController

  before_action :set_concrete_issue_template, only: [:edit, :update, :destroy]

  def index
    @templates = IssueTemplate.all
  end

  def new
    @concrete_issue_template = ConcreteIssueTemplate.new
    @issue_template = IssueTemplate.find_by(id: params[:issue_template_id])
    @predefined_attributes = @issue_template.issue_template_attributes
  end

  def create
  end

  def edit
    @predefined_attributes = @concrete_issue_template.issue_template
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
