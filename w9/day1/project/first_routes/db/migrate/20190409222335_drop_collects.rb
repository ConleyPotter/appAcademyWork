class DropCollects < ActiveRecord::Migration[5.2]
  def change
    drop_table :collects
  end
end
