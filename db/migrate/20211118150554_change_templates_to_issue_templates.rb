class ChangeTemplatesToIssueTemplates < ActiveRecord::Migration[6.0]
  def change
    rename_table :templates, :issue_templates
  end
end
