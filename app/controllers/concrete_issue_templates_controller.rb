class ConcreteIssueTemplatesController < ApplicationController
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
end
