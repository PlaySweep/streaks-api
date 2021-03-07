class CreatePicks < ActiveRecord::Migration[5.2]
  def change
    create_table :picks do |t|
      t.references :user, foreign_key: true
      t.references :matchup, foreign_key: true
      t.references :selection, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
