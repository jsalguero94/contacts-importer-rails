require 'rails_helper'

RSpec.describe 'CsvFiles', type: :request do
  before do
    new_user = create :user
    sign_in new_user
  end

  describe 'GET /index' do
    it 'render index'
  end

  it 'new csv file' do
    get new_csv_file_path
    expect(response.body).to include 'Upload Csv File'
    expect(response).to have_http_status(:ok)
  end

  it 'upload a CsvFile' do
    csv_to_upload = Rack::Test::UploadedFile.new('spec/support/fixtures/contact1.csv')
    post csv_files_path, params: { csv_file: { csv: csv_to_upload } }

    follow_redirect!
    expect(response.body).to include 'Csv file uploaded successfully.'
    expect(response).to have_http_status(:ok)
  end

  it 'upload failed' do
    csv_to_upload = Rack::Test::UploadedFile.new('spec/support/fixtures/contact1.txt')
    post csv_files_path, params: { csv_file: { csv: csv_to_upload } }

    expect(response.body).to include 'Csv must be a csv file'
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
