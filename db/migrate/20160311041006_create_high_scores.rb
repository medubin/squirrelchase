class CreateHighScores < ActiveRecord::Migration
  def change
    create_table :high_scores do |t|
      t.integer :score, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
    add_index :high_scores, :name
  end
end
