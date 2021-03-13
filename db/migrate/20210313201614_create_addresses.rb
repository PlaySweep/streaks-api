class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country, default: "United States"

      t.timestamps
    end
  end
end
