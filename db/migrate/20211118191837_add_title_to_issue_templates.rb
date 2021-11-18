class AddTitleToIssueTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :issue_templates, :title, :string
  end
end
