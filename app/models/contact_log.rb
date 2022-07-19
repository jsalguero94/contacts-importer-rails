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
class ContactLog < ApplicationRecord
  belongs_to :user
  belongs_to :csv_file
end
