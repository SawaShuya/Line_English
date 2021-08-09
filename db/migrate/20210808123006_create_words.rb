class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.integer :list_id, null: false
      t.string :english
      t.string :japanese
      t.boolean :is_remembered, null: false, default: false

      t.timestamps
    end
  end
end
