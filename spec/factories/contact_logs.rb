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
