class AddSharesToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :shares, :integer
  end
end
