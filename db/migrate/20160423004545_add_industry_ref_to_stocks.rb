class AddIndustryRefToStocks < ActiveRecord::Migration
  def change
    add_reference :stocks, :industry, index: true, foreign_key: true
  end
end
