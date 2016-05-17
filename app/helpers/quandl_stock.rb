module QuandlStockHelper

  def stock_percentage

  end

  def hash_to_array(hash)
    array = []
    hash.each do |h|
      temp =[]
      h.each do |key,value|
        if key == "date" || "value"
          temp << value
        end
      end
      array <<temp
    end
    array.each do |a|
      a.delete_at(1)
      a.delete_at(1)
    end
    return array
  end

end


#allocation based off of holding percent (one stock)
  #stock percentage of portfolio

#Adds up stock  percentage of portfolio
  #final hash

#Array of hashes to array of arrays
  #from quandl json has only need [date] and percent [value]

#High chart needs [x, y]
