class CreateIssueTemplateAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :issue_template_attributes do |t|
      t.belongs_to :issue_template, foreign_key: true
      t.integer :type
      t.string :field_title
      t.string :field_value

      t.timestamps
    end
  end
end
