class AddCodeToPrizes < ActiveRecord::Migration[5.2]
  def change
    add_column :prizes, :code, :string
  end
end
