class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.references :round, foreign_key: true
      t.integer :status, default: 0
      t.integer :picks_won_count, default: 0
      t.boolean :bonus, default: false

      t.timestamps
    end
  end
end
