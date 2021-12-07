class ConcreteTemplateValue < ApplicationRecord

  belongs_to :concrete_issue_template
  belongs_to :issue_template_attribute

  serialize :dynamic_size_data, Hash

end
