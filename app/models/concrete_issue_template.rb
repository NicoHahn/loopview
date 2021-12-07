class ConcreteIssueTemplate < ApplicationRecord

  has_many :concrete_template_values, dependent: :destroy
  belongs_to :issue_template
  belongs_to :project

  accepts_nested_attributes_for :concrete_template_values

  def connect_with_issue(external_id)
    self.update(external_id: external_id)
  end

end
