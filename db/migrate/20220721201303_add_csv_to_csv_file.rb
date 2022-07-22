class AddCsvToCsvFile < ActiveRecord::Migration[7.0]
  def change
    add_column :csv_files, :csv,:string,default:'Active Storage', null: false
  end
end
