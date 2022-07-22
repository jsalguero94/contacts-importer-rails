# frozen_string_literal: true

class ContactLogsController < ApplicationController
  def index
    @contact_logs = current_user.contact_logs.includes(:csv_file).page params[:page]
  end
end
