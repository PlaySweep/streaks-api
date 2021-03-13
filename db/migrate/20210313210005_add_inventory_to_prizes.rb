class AddInventoryToPrizes < ActiveRecord::Migration[5.2]
  def change
    add_column :prizes, :inventory, :integer, default: 0
  end
end
