class ChangeColumnsToRequireFromContacts < ActiveRecord::Migration[7.0]
  def up
    change_column :contacts, :name, :string, null: false
    change_column :contacts, :date_of_birth, :date, null: false
    change_column :contacts, :phone, :string, null: false
    change_column :contacts, :address, :string, null: false
    change_column :contacts, :credit_card, :string, null: false
    change_column :contacts, :email, :string, null: false
  end

  def down
    change_column :contacts, :name, :string, null: true
    change_column :contacts, :date_of_birth, :date, null: true
    change_column :contacts, :phone, :string, null: true
    change_column :contacts, :address, :string, null: true
    change_column :contacts, :credit_card, :string, null: true
    change_column :contacts, :email, :string, null: true
  end
end
