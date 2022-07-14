FactoryBot.define do
  factory :contact do
    name { "MyString" }
    date_of_birth { "2022-07-14" }
    phone { "MyString" }
    address { "MyString" }
    credit_card { 1 }
    cc_last_four_numbers { 1 }
    credit_card_network { "MyString" }
    email { "MyString" }
    user { nil }
    csv_file { nil }
  end
end
