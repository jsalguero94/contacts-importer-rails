class CsvFile < ApplicationRecord
  belongs_to :user
  enum :status, { 'On Hold': 0, Processing: 1, Failed: 2, Finished: 3 }

  validates :name, presence: true
end
