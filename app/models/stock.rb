class Stock < ActiveRecord::Base
  has_many :portfolios
  has_many :users, through: :portfolios
  belongs_to :industry
end
