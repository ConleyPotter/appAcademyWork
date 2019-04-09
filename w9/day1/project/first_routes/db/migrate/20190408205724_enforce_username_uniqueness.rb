class EnforceUsernameUniqueness < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :username, :string
    add_column :users, :username, :string, uniqueness: true
  end
end
