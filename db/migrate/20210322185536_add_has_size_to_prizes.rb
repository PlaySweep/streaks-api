class AddHasSizeToPrizes < ActiveRecord::Migration[5.2]
  def change
    add_column :prizes, :has_size, :boolean, default: false
  end
end
