class CsvFile < ApplicationRecord
  belongs_to :user
  has_one_attached :csv
  enum :status, { 'On Hold': 0, Processing: 1, Failed: 2, Finished: 3 }

  validates :csv, presence: true
end
