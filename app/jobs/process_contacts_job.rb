# frozen_string_literal: true

class ProcessContactsJob < ApplicationJob
  queue_as :default

  def perform(csv_file)
    csv_file.process_contacts!
  end
end
