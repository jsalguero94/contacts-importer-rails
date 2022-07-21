# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id                   :bigint           not null, primary key
#  address              :string           not null
#  cc_last_four_numbers :integer
#  credit_card          :string           not null
#  credit_card_network  :integer
#  date_of_birth        :date             not null
#  email                :string           not null
#  name                 :string           not null
#  phone                :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  csv_file_id          :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_contacts_on_csv_file_id        (csv_file_id)
#  index_contacts_on_email_and_user_id  (email,user_id) UNIQUE
#  index_contacts_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (csv_file_id => csv_files.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  cc_network = %i[amex diners discover jcb mastercard visa]
  factory :contact do
    name { 'Juan Pedro' }
    date_of_birth { '1993-07-14' }
    phone { '(+57) 320-432-05-09' }
    address { 'Guatemala' }
    sequence :credit_card do |n|
      network = cc_network[n] || cc_network.sample
      CreditCardValidations::Factory.random(network)
    end
    sequence :email do |n|
      "juan#{n}@gmail.com"
    end
    user
    csv_file { association :csv_file, user: }
  end
end
