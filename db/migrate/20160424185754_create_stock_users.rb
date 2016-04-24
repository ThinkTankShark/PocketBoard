class CreateStockUsers < ActiveRecord::Migration
  def change
    create_table :stock_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :stock, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
