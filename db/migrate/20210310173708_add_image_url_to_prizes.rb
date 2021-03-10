class AddImageUrlToPrizes < ActiveRecord::Migration[5.2]
  def change
    add_column :prizes, :image_url, :string
  end
end
