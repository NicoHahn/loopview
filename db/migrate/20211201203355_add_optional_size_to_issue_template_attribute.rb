class AddOptionalSizeToIssueTemplateAttribute < ActiveRecord::Migration[6.0]
  def change
    add_column :issue_template_attributes, :optional_size, :integer, default: 0
  end
end
