class ChangeForeignKeyForConcreteTemplateValue < ActiveRecord::Migration[6.0]
  def change
    rename_column :concrete_template_values, :issue_template_attributes_id, :issue_template_attribute_id
  end
end
