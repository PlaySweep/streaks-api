class CreateMatchups < ActiveRecord::Migration[5.2]
  def change
    create_table :matchups do |t|
      t.references :round, foreign_key: true
      t.string :description
      t.integer :status, default: 0
      t.integer :order, default: 1

      t.timestamps
    end
  end
end
