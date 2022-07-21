# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessContactsJob, type: :job do
  it 'enqueues the job as expected' do
    csv_file = create :csv_file
    expect { described_class.perform_later(csv_file) }.to have_enqueued_job(described_class)
  end

  it 'process the contacts' do
    csv_file = create :csv_file
    described_class.perform_now csv_file
    expect(Contact.count).to eq 2
  end
end
