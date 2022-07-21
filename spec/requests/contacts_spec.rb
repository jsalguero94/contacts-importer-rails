require 'rails_helper'

RSpec.describe 'Contacts Request', type: :request do
  before do
    new_user = create :user
    sign_in new_user
  end

  it 'GET /contacts' do
    get contacts_path
    expect(response.body).to include 'Contacts imported'
    expect(response).to have_http_status :ok
  end
end
