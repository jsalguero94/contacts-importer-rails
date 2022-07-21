require 'rails_helper'

RSpec.describe 'ContactLogs Request', type: :request do
  before do
    new_user = create :user
    sign_in new_user
  end

  it 'Get /contact_logs' do
    get contact_logs_path
    expect(response.body).to include 'Contact Logs'
    expect(response).to have_http_status :ok
  end
end
