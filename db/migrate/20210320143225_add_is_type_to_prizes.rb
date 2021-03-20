class AddIsTypeToPrizes < ActiveRecord::Migration[5.2]
  def change
    add_column :prizes, :is_type, :integer, default: 0
  end
end
