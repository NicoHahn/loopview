class ChangeForeignKeyForIssueTemplate < ActiveRecord::Migration[6.0]
  def change
    rename_column :concrete_issue_templates, :issue_templates_id, :issue_template_id
  end
end
