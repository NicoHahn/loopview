class CreateConcreteTemplateValues < ActiveRecord::Migration[6.0]
  def change
    create_table :concrete_template_values do |t|
      t.belongs_to :issue_template_attributes, foreign_key: true
      t.string :extended_field_value

      t.timestamps
    end
  end
end
