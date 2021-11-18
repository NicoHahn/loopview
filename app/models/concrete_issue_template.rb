class ConcreteIssueTemplate < ApplicationRecord

  has_many :concrete_template_values
  belongs_to :issue_template

end
