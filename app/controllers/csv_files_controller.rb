class CsvFilesController < ApplicationController

  def new
    @csv_file = CsvFile.new
  end

  def create
    @csv_file = current_user.csv_files.build(csv_file_params)
    respond_to do |format|
      if @csv_file.save
        ProcessContactsJob.perform_later @csv_file
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
