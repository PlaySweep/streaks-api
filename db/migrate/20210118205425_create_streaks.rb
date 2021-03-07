class CreateStreaks < ActiveRecord::Migration[5.2]
  def change
    create_table :streaks do |t|
      t.references :user, foreign_key: true
      t.integer :previous, default: 0
      t.integer :current, default: 0
      t.integer :highest, default: 0

      t.timestamps
    end
  end
end
