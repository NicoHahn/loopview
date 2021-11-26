class ConcreteIssueTemplate < ApplicationRecord

  has_many :concrete_template_values, dependent: :destroy
  belongs_to :issue_template

  accepts_nested_attributes_for :concrete_template_values

end
