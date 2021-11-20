class IssueTemplate < ApplicationRecord

  has_many :issue_template_attributes, dependent: :destroy
  accepts_nested_attributes_for :issue_template_attributes

  # scope -> :assigned_attributes ()


end

