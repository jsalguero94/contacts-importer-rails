# == Schema Information
#
# Table name: csv_files
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer          default("On Hold")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_csv_files_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :csv_file do
    association :user
    csv { Rack::Test::UploadedFile.new('spec/support/fixtures/contact1.csv') }
  end
end
