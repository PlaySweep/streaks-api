class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.string :name
      t.references :account, foreign_key: true
      t.integer :status, default: 0
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
