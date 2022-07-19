require 'csv'

class ProcessContactsJob < ApplicationJob
  queue_as :default

  def perform(csv_file)
    csv_file.update!(status: :Processing)
    CSV.parse(csv_file.csv.download, headers: true) do |n|
      contact_hash = build_contact n, csv_file
      contact = Contact.new contact_hash
      contact.save
      create_log contact, contact_hash
    end
    csv_file.contacts.count.positive? ? csv_file.update!(status: :Finished) : csv_file.update!(status: :Failed)
  end

  private

  def build_contact(contact, csv)
    hash = contact.to_h
    hash[:csv_file_id] = csv.id
    hash[:user_id] = csv.user_id
    hash
  end

  def create_log(contact, contact_hash)
    errors = contact.errors.full_messages.join ', '
    contact_hash[:error_message] = errors
    ContactLog.create(contact_hash) unless contact.persisted?
  end
end
