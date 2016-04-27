class AddImgaeUrlToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :image_url, :string
  end
end
