class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.integer :external_id
      t.string :external_key

      t.timestamps
    end
  end
end
