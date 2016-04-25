class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.string :description
      t.string :sector
      t.string :request_token
      t.string :request_key

      t.timestamps null: false
    end
  end
end
