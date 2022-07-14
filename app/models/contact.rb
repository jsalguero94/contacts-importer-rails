class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :csv_file
end
