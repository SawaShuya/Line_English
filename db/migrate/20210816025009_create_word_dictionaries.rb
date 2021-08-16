class CreateWordDictionaries < ActiveRecord::Migration[6.1]
  def change
    create_table :word_dictionaries do |t|
      t.string :english
      t.string :japanese
      t.timestamps
    end
  end
end
