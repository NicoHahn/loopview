class IssueTemplate < ApplicationRecord

  has_many :issue_template_attributes, dependent: :destroy
  has_many :concrete_issue_templates
  accepts_nested_attributes_for :issue_template_attributes

  # scope -> :assigned_attributes ()


  def created_for_project?(project)
    project.concrete_issue_templates.where(issue_template_id: self.id).any?
  end

end

