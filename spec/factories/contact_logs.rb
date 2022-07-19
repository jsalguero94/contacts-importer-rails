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
FactoryBot.define do
  factory :contact_log do
    name { 'Juan Pedro' }
    date_of_birth { '1993-07-14' }
    phone { '(+57) 320-432-05-09' }
    address { 'Guatemala' }
    credit_card { CreditCardValidations::Factory.random }
    sequence :email do |n|
      "juan#{n}@gmail.com"
    end
    error_message do
      "User must exist, Csv file must exist, Name can't be blank, Date of birth can't be blank, Phone can'\
       t be blank, Address can't be blank, Credit card can't be blank, Email can't be blank, Name is invalid, Email is\
      invalid, Phone is invalid, Date of birth must be a valid date, Credit card is invalid"
    end
    user
    csv_file { association :csv_file, user: }
  end
end
