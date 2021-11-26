class AddExternalIdToConcreteIssueTemplate < ActiveRecord::Migration[6.0]
  def change
    add_column :concrete_issue_templates, :external_id, :integer, :null=>true
  end
end
