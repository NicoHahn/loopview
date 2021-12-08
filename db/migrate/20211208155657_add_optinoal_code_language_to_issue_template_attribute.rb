class AddOptinoalCodeLanguageToIssueTemplateAttribute < ActiveRecord::Migration[6.0]
  def change
    add_column :issue_template_attributes, :optional_code_language, :string, :null => true
  end
end
