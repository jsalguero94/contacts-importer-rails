class CreateContactLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_logs do |t|
      t.string :name
      t.date :date_of_birth
      t.string :phone
      t.string :address
      t.string :credit_card
      t.integer :cc_last_four_numbers, limit: 4
      t.string :credit_card_network
      t.string :email
      t.string :error_message
      t.references :user, null: false, foreign_key: true
      t.references :csv_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end
