class AddUniqueIndexToCards < ActiveRecord::Migration[5.2]
  def change
    add_index :cards, [:round_id, :user_id], unique: true
  end
end
