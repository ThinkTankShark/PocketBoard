class Industry < ActiveRecord::Base
  has_many :stocks

  def selected?
    !seleted.blank?
  end
end
