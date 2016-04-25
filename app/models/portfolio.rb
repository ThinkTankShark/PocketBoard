class Portfolio < ActiveRecord::Base
  helper PortfoliosHelper

  belongs_to :user
  has_many :holdings
  accepts_nested_attributes_for :holdings,
    :allow_destroy => true,
    :reject_if     => :all_blank
end
