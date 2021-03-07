class CreatePrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :prizes do |t|
      t.string :name
      t.string :description
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
