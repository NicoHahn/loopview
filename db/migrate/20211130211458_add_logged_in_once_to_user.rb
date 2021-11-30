class AddLoggedInOnceToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :passwd_changed, :boolean, default: false
  end
end
