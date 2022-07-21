# frozen_string_literal: true

# == Schema Information
#
# Table name: csv_files
#
#  id         :bigint           not null, primary key
#  csv        :string           default("Active Storage"), not null
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
require 'csv'
class CsvFile < ApplicationRecord
  before_save :assign_csv_name

  belongs_to :user
  has_many :contacts, dependent: :destroy
  has_many :contact_logs, dependent: :destroy
  has_one_attached :csv
  enum :status, { 'On Hold': 0, Processing: 1, Failed: 2, Finished: 3 }

  validates :csv, presence: true
  validate :csv_file?

  after_commit :start_process_contacts, on: :create

  def start_process_contacts!
    update!(status: :Processing)
    process_contacts
  end

  def process_contacts!
    CSV.parse(csv.download, headers: true) do |n|
      contact_hash = build_contact n
      contact = Contact.new contact_hash
      contact.save
      create_log contact, contact_hash
    end
    contacts.count.positive? ? update!(status: :Finished) : update!(status: :Failed)
  end

  private

  def csv_file?
    return unless csv.filename

    errors.add(:csv, 'must be a csv file') unless csv.filename.extension_with_delimiter.eql? '.csv'
  end

  def assign_csv_name
    self.name = csv.blob.filename
  end

  def start_process_contacts
    StartProcessContactsJob.perform_later self
  end

  def process_contacts
    ProcessContactsJob.perform_later self
  end

  def build_contact(contact)
    hash = contact.to_h
    hash[:csv_file_id] = id
    hash[:user_id] = user_id
    hash
  end

  def create_log(contact, contact_hash)
    errors = contact.errors.full_messages.join ', '
    contact_hash[:error_message] = errors
    ContactLog.create(contact_hash) unless contact.persisted?
  end
end
