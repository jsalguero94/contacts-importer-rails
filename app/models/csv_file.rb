class CsvFile < ApplicationRecord
  before_save :assign_csv_name

  belongs_to :user
  has_many :contacts, dependent: :destroy
  has_many :contact_logs, dependent: :destroy
  has_one_attached :csv
  enum :status, { 'On Hold': 0, Processing: 1, Failed: 2, Finished: 3 }

  validates :csv, presence: true
  validate :csv_file?

  private

  def csv_file?
    return unless csv.filename

    errors.add(:csv, 'must be a csv file') unless csv.filename.extension_with_delimiter.eql? '.csv'
  end

  def assign_csv_name
    self.name = csv.blob.filename
  end
end
