class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :user_id, null: false
      t.integer :word_id, null: false
      t.integer :answer, null: false
      t.boolean :is_collected, null: false, default: false
      t.boolean :is_sent, null: false, default: false

      t.timestamps
    end
  end
end
