class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.integer :user_id, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
