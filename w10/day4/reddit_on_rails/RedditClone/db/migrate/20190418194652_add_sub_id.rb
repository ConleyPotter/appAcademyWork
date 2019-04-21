class AddSubId < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :sub_id, :integer
  end
end
