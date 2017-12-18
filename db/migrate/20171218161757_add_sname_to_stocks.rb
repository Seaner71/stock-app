class AddSnameToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :sname, :string
  end
end
