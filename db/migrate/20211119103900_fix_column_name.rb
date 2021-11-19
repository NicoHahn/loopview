class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :issue_template_attributes, :type, :attribute_type
  end
end
