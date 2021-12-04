class AddDynamicSizeDataToConcreteTemplateValue < ActiveRecord::Migration[6.0]
  def change
    add_column :concrete_template_values, :dynamic_size_data, :text
  end
end
