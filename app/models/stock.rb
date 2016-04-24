class Stock < ActiveRecord::Base
  has_many :holdings
  has_many :stocks_user
  belongs_to :industry
end
