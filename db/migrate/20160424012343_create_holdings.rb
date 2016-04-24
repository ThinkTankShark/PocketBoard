class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.string :symbol
      t.integer :allocation

      t.timestamps null: false
    end
  end
end
