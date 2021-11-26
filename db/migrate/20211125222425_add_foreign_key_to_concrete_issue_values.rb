class AddForeignKeyToConcreteIssueValues < ActiveRecord::Migration[6.0]
  def change
    add_reference :concrete_template_values, :concrete_issue_template, foreign_key: true
  end
end
