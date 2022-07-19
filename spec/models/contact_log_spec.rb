# == Schema Information
#
# Table name: contact_logs
#
#  id                   :bigint           not null, primary key
#  address              :string
#  cc_last_four_numbers :integer
#  credit_card          :string
#  credit_card_network  :string
#  date_of_birth        :date
#  email                :string
#  error_message        :string
#  name                 :string
#  phone                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  csv_file_id          :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_contact_logs_on_csv_file_id  (csv_file_id)
#  index_contact_logs_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (csv_file_id => csv_files.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ContactLog, type: :model do
  it 'has valid factory' do
    contact = create :contact_log
    expect(contact).to be_persisted end

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :csv_file }
  end

  describe 'credit card' do
    it 'auto assign credit card network' do
      cc = create :contact_log, credit_card: '4111111111111111', credit_card_network: nil
      expect(cc.credit_card_network).to eq 'Visa'
    end

    it 'nil if not valid' do
      cc = create :contact_log, credit_card: '4111111'
      expect(cc.credit_card_network).to be_nil
    end

    it 'saves last 4 numbers' do
      cc = create :contact_log, credit_card: '4111111111111111'
      expect(cc.cc_last_four_numbers).to eq 1111
    end

    it 'last four numbers nil if number < 4' do
      cc = create :contact_log, credit_card: '123'
      expect(cc.cc_last_four_numbers).to be_nil
    end

    it 'encrypt credit card' do
      cc = create :contact_log
      expect(cc.credit_card).to be_valid_encoding
    end
  end
end
