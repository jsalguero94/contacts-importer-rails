class Contact < ApplicationRecord
  before_save :credit_card_assignments

  belongs_to :user
  belongs_to :csv_file
  enum :credit_card_network, { 'American Express': 0, 'Diners Club': 1, Discover: 2, JCB: 3, MasterCard: 4, Visa: 5 }

  validates :name, :date_of_birth, :phone, :address, :credit_card, :email, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9 -]+\z/ }
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :phone, format:
    {
      with: \
      /\A(\(\+[0-9]{2}\) [0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2})|(\(\+[0-9]{2}\) [0-9]{3} [0-9]{3} [0-9]{2} [0-9]{2})\z/
    }
  validate :date_of_birth_is_date?
  validates :email, uniqueness: { scope: :user_id }
  validates :credit_card, credit_card_number: { brands: %i[amex diners discover jcb mastercard visa] }

  private

  def date_of_birth_is_date?
    errors.add(:date_of_birth, 'must be a valid date') unless date_of_birth.is_a?(Date)
  end

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