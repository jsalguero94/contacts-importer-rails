# == Schema Information
#
# Table name: contacts
#
#  id                   :bigint           not null, primary key
#  address              :string
#  cc_last_four_numbers :integer
#  credit_card          :string
#  credit_card_network  :integer
#  date_of_birth        :date
#  email                :string
#  name                 :string
#  phone                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  csv_file_id          :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_contacts_on_csv_file_id        (csv_file_id)
#  index_contacts_on_email_and_user_id  (email,user_id) UNIQUE
#  index_contacts_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (csv_file_id => csv_files.id)
#  fk_rails_...  (user_id => users.id)
#
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
      it 'is invalid' do
        name = build(:contact, name: 'Juan@ Romero')
        expect(name).not_to be_valid
        expect(name.errors.messages[:name]).to include('is invalid')
      end

      it 'is valid' do
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
      it 'is valid with spaces' do
        phone = build(:contact, phone: '(+57) 320 432 05 09')
        expect(phone).to be_valid
      end

      it 'is valid with hyphen' do
        phone = build(:contact, phone: '(+57) 320-432-05-09')
        expect(phone).to be_valid
      end

      it 'is invalid' do
        phone = build(:contact, phone: '(57) 320 432 05-09')
        expect(phone).not_to be_valid
        expect(phone.errors.messages[:phone]).to include('is invalid')
      end
    end
  end

  describe 'email' do
    it 'has valid format' do
      user = build :contact, email: 'jhon'
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include('is invalid')
    end

    it 'is unique by user' do
      contact = create :contact
      contact2 = build :contact, user: contact.user, email: contact.email
      expect(contact2).not_to be_valid
      expect(contact2.errors.messages[:email]).to include('has already been taken')
    end

    it 'is same with different user' do
      create :contact
      contact2 = build :contact, user: (create :user, email: 'otheruser@g.com')
      expect(contact2).to be_valid
    end
  end

  describe 'credit card' do
    it 'validates number' do
      cc = build :contact, credit_card: '1234'
      expect(cc).not_to be_valid
      expect(cc.errors.messages[:credit_card]).to include('is invalid')
      cc = build :contact, credit_card: '4222318270101116'
      expect(cc).to be_valid
    end

    it 'auto assign credit card network' do
      cc = create :contact, credit_card: '4111111111111111', credit_card_network: nil
      expect(cc.credit_card_network).to eq 'Visa'
    end

    it 'saves last 4 numbers' do
      cc = create :contact, credit_card: '4111111111111111'
      expect(cc.cc_last_four_numbers).to eq 1111
    end

    it 'encrypt credit card' do
      cc = create :contact
      expect(cc.credit_card).to be_valid_encoding
    end

    it 'creates all networks' do
      FactoryBot.reload
      cc = create_list :contact, 6
      expect(cc).to all(be_persisted)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :csv_file }
  end
end
