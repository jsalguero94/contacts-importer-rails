require 'rails_helper'

RSpec.describe CsvFile, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:csv_file)).to be_valid
    end

    it { is_expected.to validate_presence_of :csv }
  end

  describe 'status' do
    it { is_expected.to define_enum_for(:status).with_values([:'On Hold', :Processing, :Failed, :Finished]) }

    it 'has On Hold Status default value' do
      csv_file = build :csv_file
      expect(csv_file.status).to eq('On Hold')
    end
  end

  describe 'attached' do
    it { is_expected.to have_one_attached(:csv) }

    it 'saves csv file' do
      csv_file = create :csv_file
      expect(csv_file).to be_valid
      expect(csv_file.csv.attached?).to be true
    end
  end

  describe 'name' do
    it "saves name's file" do
      csv_file = create :csv_file
      expect(csv_file.name).to eq 'contact1.csv'
    end

    it 'is csv file' do
      csv_file = build :csv_file
      expect(csv_file).to be_valid
    end

    it 'is not csv file' do
      csv_file = build :csv_file, csv: Rack::Test::UploadedFile.new('spec/support/fixtures/contact1.txt')
      expect(csv_file).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:contacts) }
  end
end
