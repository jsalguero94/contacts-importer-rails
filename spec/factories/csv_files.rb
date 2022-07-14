FactoryBot.define do
  factory :csv_file do
    name { 'file1.csv' }
    association :user
  end
end
