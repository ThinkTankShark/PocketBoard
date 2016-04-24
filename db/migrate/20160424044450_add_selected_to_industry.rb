class AddSelectedToIndustry < ActiveRecord::Migration
  def change
    add_column :industries, :selected, :boolean
  end
end
