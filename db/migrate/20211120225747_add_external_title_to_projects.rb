class AddExternalTitleToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :external_title, :string
  end
end
