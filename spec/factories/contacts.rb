FactoryBot.define do
  factory :contact do
    name { 'Juan Pedro' }
    date_of_birth { '1993-07-14' }
    phone { '(+57) 320-432-05-09' }
    address { 'Guatemala' }
    credit_card { 1 }
    # cc_last_four_numbers { 1 }
    # credit_card_network { 'Visa' }
    email { 'juan@gmail.com' }
    user
    csv_file { association :csv_file, user: }
  end
end
