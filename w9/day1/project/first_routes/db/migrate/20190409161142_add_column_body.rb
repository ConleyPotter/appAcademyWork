class AddColumnBody < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :body, :string, null: false
  end
end
