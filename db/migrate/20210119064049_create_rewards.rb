class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.references :user, foreign_key: true
      t.references :prize, foreign_key: true
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
