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
