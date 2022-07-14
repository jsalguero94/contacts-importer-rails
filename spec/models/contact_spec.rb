require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:contact)).to be_valid
    end

    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :date_of_birth }

    it { is_expected.to validate_presence_of :phone }

    it { is_expected.to validate_presence_of :address }

    it { is_expected.to validate_presence_of :credit_card }

    it { is_expected.to validate_presence_of :email }

    describe 'name' do
      it 'invalid name' do
        name = build(:contact, name: 'Juan@ Romero')
        expect(name).not_to be_valid
      end

      it 'valid name' do
        name = build(:contact, name: 'Juan- Romero')
        expect(name).to be_valid
      end
    end

    it 'validates date' do
      date1 = build(:contact, date_of_birth: '2000-22-22')
      expect(date1).not_to be_valid
      expect(date1.errors.messages[:date_of_birth]).to include('must be a valid date')
    end

    describe 'phone' do
      it 'is valid phone with spaces' do
        phone = build(:contact, phone: '(+57) 320 432 05 09')
        expect(phone).to be_valid
      end

      it 'is valid phone with hyphen' do
        phone = build(:contact, phone: '(+57) 320-432-05-09')
        expect(phone).to be_valid
      end

      it 'is invalid phone' do
        phone = build(:contact, phone: '(57) 320 432 05-09')
        expect(phone).not_to be_valid
      end
    end

    it 'validates email format' do
      user = build :contact, email: 'jhon'
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include('is invalid')
    end
  end

  describe 'email' do
    it 'is unique by user' do
      contact = create :contact
      contact2 = build :contact, user: contact.user
      expect(contact2).not_to be_valid
    end

    it 'same email different user' do
      create :contact
      contact2 = build :contact, user: (create :user, email: 'otheruser@g.com')
      expect(contact2).to be_valid
    end
  end

  describe 'credit card' do
    it 'validates number' do
      cc = build :contact, credit_card: 1234
      expect(cc).not_to be_valid
      cc = build :contact, credit_card: 4_222_318_270_101_116
      expect(cc).to be_valid
    end

    it 'auto assign credit card network' do
      cc = create :contact, credit_card: 4_111_111_111_111_111, credit_card_network: nil
      expect(cc.credit_card_network).to eq 'Visa'
    end

    it 'saves last 4 numbers' do
      cc = create :contact, credit_card: 4_111_111_111_111_111
      expect(cc.cc_last_four_numbers).to eq 1111
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :csv_file }
  end
end
