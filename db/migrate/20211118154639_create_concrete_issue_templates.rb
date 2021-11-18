class CreateConcreteIssueTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :concrete_issue_templates do |t|
      t.belongs_to :issue_templates, foreign_key: true


      t.timestamps
    end
  end
end
