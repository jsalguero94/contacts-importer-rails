class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :date_of_birth
      t.string :phone
      t.string :address
      t.integer :credit_card
      t.integer :cc_last_four_numbers, limit: 4
      t.integer :credit_card_network
      t.string :email
      t.references :user, null: false, foreign_key: true
      t.references :csv_file, null: false, foreign_key: true

      t.timestamps
    end
    add_index :contacts, [:email, :user_id], unique: true
  end
end
