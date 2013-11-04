class ChangeUserNameToUsername < ActiveRecord::Migration
  def up
    rename_column :users, :name, :username
  end

  def down
    rename_columns :users, :username, :name
  end

end
