class IssueTemplate < ApplicationRecord

  has_many :issue_template_attributes, dependent: :destroy

  # scope -> :assigned_attributes ()


end

