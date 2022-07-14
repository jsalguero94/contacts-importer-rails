require 'rails_helper'

RSpec.describe CsvFile, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:csv_file)).to be_valid
    end

    it { is_expected.to validate_presence_of :name }

    it 'has On Hold Status default value' do
      csv_file = build :csv_file
      expect(csv_file.status).to eq('On Hold')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
