# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StartProcessContactsJob, type: :job do
  it 'enqueues the job as expected' do
    csv_file = create :csv_file
    expect { described_class.perform_later(csv_file) }.to have_enqueued_job(described_class)
  end

  it 'starts the process contacts' do
    csv_file = create :csv_file
    expect(csv_file.Processing?).to be false
    described_class.perform_now csv_file
    expect(csv_file.Processing?).to be true
  end
end
