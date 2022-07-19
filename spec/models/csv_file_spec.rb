# == Schema Information
#
# Table name: csv_files
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer          default("On Hold")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_csv_files_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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

    it 'has On Hold default value' do
      csv_file = build :csv_file
      expect(csv_file.status).to eq('On Hold')
    end

    it 'is Processing' do
      csv_file = create :csv_file
      csv_file.start_process_contacts!
      expect(csv_file.Processing?).to be true
    end

    it 'is Finished' do
      csv_file = create :csv_file
      csv_file.process_contacts!
      expect(csv_file.Finished?).to be true
    end

    it 'is Failed' do
      csv_file = create :csv_file
      csv_file.process_contacts!
      csv_file = create :csv_file, user: csv_file.user
      csv_file.process_contacts!
      expect(csv_file.Failed?).to be true
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

  it('has StartProcessContactsJob') { expect { create(:csv_file) }.to have_enqueued_job(StartProcessContactsJob) }

  it 'has ProcessContactsJob' do
    expect { create(:csv_file).start_process_contacts! }.to have_enqueued_job(ProcessContactsJob)
  end

  it '#process contacts' do
    csv_file = create :csv_file
    csv_file.process_contacts!
    expect(Contact.count).to eq 2
  end
end
