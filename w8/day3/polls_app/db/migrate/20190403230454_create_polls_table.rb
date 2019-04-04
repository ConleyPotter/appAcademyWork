class CreatePollsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :author_id

      t.timestamps
    end
  end
end
