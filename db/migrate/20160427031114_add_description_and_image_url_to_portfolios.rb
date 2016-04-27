class AddDescriptionAndImageUrlToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :description, :string
    add_column :portfolios, :image_url, :string
  end
end
