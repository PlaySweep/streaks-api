class AddReferredByIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :referred_by_id, :integer, foreign_key: true
  end
end
