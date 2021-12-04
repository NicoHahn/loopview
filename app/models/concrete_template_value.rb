class ConcreteTemplateValue < ApplicationRecord

  belongs_to :concrete_issue_template

  serialize :dynamic_size_data, Hash

end
