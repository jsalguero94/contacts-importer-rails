class Contact < ApplicationRecord
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

  def date_of_birth_is_date?
    errors.add(:date_of_birth, 'must be a valid date') unless date_of_birth.is_a?(Date)
  end
end
