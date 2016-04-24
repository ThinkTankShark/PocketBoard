class Stock < ActiveRecord::Base
  has_many :holdings
  belongs_to :industry
end
