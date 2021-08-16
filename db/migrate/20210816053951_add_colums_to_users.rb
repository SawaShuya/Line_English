class AddColumsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :question_list_id, :integer
    add_column :users, :question_limit, :integer, default: 5
    add_column :users, :is_remember_word_question, :boolean, default: true
    add_column :users, :is_question, :boolean, default: true
  end
end
