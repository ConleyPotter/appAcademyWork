class ChangeUsersColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    remove_column :users, :name, :string
    remove_column :users, :email, :string
  end
end
