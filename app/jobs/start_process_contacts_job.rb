class StartProcessContactsJob < ApplicationJob
  queue_as :default

  def perform(csv_file)
    csv_file.start_process_contacts!
  end
end
