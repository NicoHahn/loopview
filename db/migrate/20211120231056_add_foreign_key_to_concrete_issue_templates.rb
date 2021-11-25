class AddForeignKeyToConcreteIssueTemplates < ActiveRecord::Migration[6.0]
  def change
    add_reference :concrete_issue_templates, :project, foreign_key: true
  end
end
