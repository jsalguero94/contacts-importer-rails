class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :util_variables

  private

  def util_variables
    contacts_counts
    csv_counts
  end

  def contacts_counts
    @contacts_count = current_user.contacts.count
    @contacts_failed_count = current_user.contact_logs.count
  end

  def csv_counts
    @csv_on_hold = current_user.csv_files.On_Hold.count
    @csv_processing = current_user.csv_files.Processing.count
    @csv_finished = current_user.csv_files.Finished.count
    @csv_failed = current_user.csv_files.Failed.count
  end
end
