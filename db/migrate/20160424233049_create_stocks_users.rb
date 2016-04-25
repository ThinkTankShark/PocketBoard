class CreateStocksUsers < ActiveRecord::Migration
  def change
    create_table :stocks_users do |t|
      t.integer :user_id
      t.integer :stock_id

      t.timestamps null: false
    end
  end
end
