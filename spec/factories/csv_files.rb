FactoryBot.define do
  factory :csv_file do
    association :user
    csv { Rack::Test::UploadedFile.new('spec/support/fixtures/contact1.csv', 'csv') }
  end
end
