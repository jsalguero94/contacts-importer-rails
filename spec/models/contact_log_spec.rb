require 'rails_helper'

RSpec.describe ContactLog, type: :model do
  it 'has valid factory' do
    contact = create :contact_log
    expect(contact).to be_persisted
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :csv_file }
  end
end
