class AddReturnImageToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :return_image, :boolean
  end
end
