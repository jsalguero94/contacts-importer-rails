require 'rails_helper'

RSpec.describe 'CsvFiles', type: :request do
  describe 'GET /index' do
    it 'render index'
  end

  it 'upload a CsvFile and redirects to Home' do
    get '/csv_files/new'
    expect(response).to render_template(:new)

    post '/csv_files', params: { csv_file: { csv: 'My Widget' } }

    expect(response).to redirect_to('/')
    follow_redirect!

    expect(response).to render_template(:index)
    expect(response.body).to include('Csv file was uploaded successfully.')
  end

  it 'does not render a different template' do
    get '/csv_files/new'
    expect(response).not_to render_template(:show)
  end
end
