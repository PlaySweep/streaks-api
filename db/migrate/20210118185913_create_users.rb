class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :account, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :email
      t.string :password_digest
      t.boolean :active, default: true
      t.boolean :eligible, default: false

      t.timestamps
    end
  end
end
