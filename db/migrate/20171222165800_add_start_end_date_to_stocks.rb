class AddStartEndDateToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :start_date, :string
    add_column :stocks, :end_date, :string
  end
end
