# frozen_string_literal: true

class CsvFilesController < ApplicationController
  def index
    @csv_files = current_user.csv_files.all.page params[:page]
  end

  def new
    @csv_file = current_user.csv_files.build
  end

  def create
    @csv_file = current_user.csv_files.build(csv_file_params)
    respond_to do |format|
      if @csv_file.save
        format.html { redirect_to root_path, notice: t('.success') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def csv_file_params
    params.require(:csv_file).permit(:csv)
  end
end
