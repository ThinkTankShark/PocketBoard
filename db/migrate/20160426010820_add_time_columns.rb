class AddTimeColumns < ActiveRecord::Migration
  def change
    add_column :portfolios, :start_time, :string
    add_column :portfolios, :end_time, :string
  end
end

