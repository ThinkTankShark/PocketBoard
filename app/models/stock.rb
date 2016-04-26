class Stock < ActiveRecord::Base
  has_many :holdings
  has_many :stocks_users
  has_many :users, through: :stocks_users
  has_many :portfolios, through: :holdings

  belongs_to :industry
end
