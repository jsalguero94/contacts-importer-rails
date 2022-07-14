class ChangeTypeCreditCardToBigInt < ActiveRecord::Migration[7.0]
  def change
    change_column :contacts, :credit_card, :bigint
  end
end
