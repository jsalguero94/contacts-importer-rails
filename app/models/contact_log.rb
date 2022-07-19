class ContactLog < ApplicationRecord
  before_save :credit_card_assignments
  belongs_to :user
  belongs_to :csv_file

  private

  def credit_card_assignments
    asign_cc_network
    save_last_4_numbers
    encrypt_credit_card
  end

  def asign_cc_network
    self.credit_card_network = CreditCardValidations::Detector.new(credit_card).brand_name
  end

  def save_last_4_numbers
    self.cc_last_four_numbers = credit_card[-4..]
  end

  def encrypt_credit_card
    self.credit_card = BCrypt::Password.create(credit_card)
  end
end
