class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  require 'uri'
  require 'date'


  def yahoo_table(snp) #also work for DJI
    snp_result = []
    snp.each_with_index do |d,t|
      snp_result[t] = {}
      snp_result[t]['date'] = snp[snp.length-t-1]['date']
      snp_result[t]['adj_close'] = snp[snp.length-t-1]['adjusted_close']

      unless t==0
        snp_result[t]['change'] = snp[snp.length-t-1]['adjusted_close']/snp[snp.length-t]['adjusted_close']-1
      else
        snp_result[t]['change'] = 0
      end

      if t == 0
        snp_result[t]['value'] = 100
      else
        snp_result[t]['value'] = snp_result[t-1]['value']*(1+snp_result[t]['change'])
      end

      snp_result[t]['year'] = snp_result[t]['date'].year
      snp_result[t]['month'] = snp_result[t]['date'].month-1
      snp_result[t]['day'] = snp_result[t]['date'].day
    end
    return snp_result;
  end

  def nasdaq_table(nasdaq)
    nasdaq_result = []
    nasdaq.each_with_index do |d,t|
      nasdaq_result[t] = {}
      nasdaq_result[t]['date'] = nasdaq[nasdaq.length-t-1]['trade_date']
      nasdaq_result[t]['adj_close'] = nasdaq[nasdaq.length-t-1]['index_value']

      unless t==0
        nasdaq_result[t]['change'] = nasdaq[nasdaq.length-t-1]['index_value']/nasdaq[nasdaq.length-t]['index_value']-1
      else
        nasdaq_result[t]['change'] = 0
      end

      if t == 0
        nasdaq_result[t]['value'] = 100
      else
        nasdaq_result[t]['value'] = nasdaq_result[t-1]['value']*(1+nasdaq_result[t]['change'])
      end

      nasdaq_result[t]['year'] = nasdaq_result[t]['date'].year
      nasdaq_result[t]['month'] = nasdaq_result[t]['date'].month-1
      nasdaq_result[t]['day'] = nasdaq_result[t]['date'].day

    end
    return nasdaq_result;
  end

  def stock_table(stock)
    stock_result = []
    stock.each_with_index do |d,t|
      stock_result[t] = {}
      stock_result[t]['date'] = stock[stock.length-t-1]['date']
      stock_result[t]['close'] = stock[stock.length-t-1]['close']

      unless t==0
        stock_result[t]['change'] = stock[stock.length-t-1]['close']/stock[stock.length-t]['close']-1
      else
        stock_result[t]['change'] = 0
      end

      if t == 0
        stock_result[t]['value'] = 100
      else
        stock_result[t]['value'] = stock_result[t-1]['value']*(1+stock_result[t]['change'])
      end

      stock_result[t]['year'] = stock_result[t]['date'].year
      stock_result[t]['month'] = stock_result[t]['date'].month-1
      stock_result[t]['day'] = stock_result[t]['date'].day

    end
    return stock_result;
  end


  def user_signed_in?
    if session[:id].nil?
      return false
    else
      return true
    end
  end

  def nytimes(query, begin_date, end_date)
    link = URI.escape("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{query}&fq=news_desk:(\"Finance\", \"Business\", \"SundayBusiness\")&begin_date=#{begin_date}&end_date=#{end_date}&api-key=")
    link = link + ENV['KEY']
    result = RestClient.get link

    return result
  end

  def quan(query, start_date, end_date)
    if query == "snp"
      snp = Quandl::Dataset.get("YAHOO/INDEX_GSPC").data(params: { start_date: "#{start_date}", end_date: "#{end_date}" }) # ["date", "open", "high", "low", "close", "volume", "adjusted_close"]
      snp_result = yahoo_table(snp)
      return snp_result
    elsif query == "nasdaq"
      nasdaq = Quandl::Dataset.get("NASDAQOMX/COMP").data(params: {start_date: "#{start_date}", end_date: "#{end_date}" }) # ["trade_date", "index_value", "high", "low", "total_market_value", "dividend_market_value"]
      nasdaq_result = nasdaq_table(nasdaq)
      return nasdaq_result
    elsif query == "dji"
      dji = Quandl::Dataset.get("YAHOO/INDEX_DJI").data(params: {start_date: "#{start_date}", end_date: "#{end_date}" }) # ["date", "open", "high", "low", "close", "volume", "adjusted_close"]
      dji_result = yahoo_table(dji)
      return dji_result
    else
      stock = Quandl::Dataset.get("GOOG/NASDAQ_#{query}").data(params: { start_date: "#{start_date}", end_date: "#{end_date}" }) # ["date", "open", "high", "low", "close", "volume"]
      stock_result = stock_table(stock)
      return stock_result
    end
  end

# Convert quandl api json date information into array of arrays with [month, day, year]
  def date_array(hash)
    array = []
    hash.each do |h|
      temp =[]
      h.each do |key,value|
        if key == "month"
          temp << value
        end
        if key == "day"
          temp << value
        end
        if key == "year"
          temp << value
        end
      end
      array << temp
    end
    return array
  end

#  Convert quandl api json value information into array
  def value_array(hash)
    array = []
    hash.each do |h|
      h.each do |key,value|
        if key == "value"
          array << value
        end
      end
    end
    return array
  end

# Multiply the values by the allocation given i.e. 100 * 0.33 = 33
  def value_allocation(array,allocation)
    temp =[]
    array.map do |a|
      temp << a * allocation.to_f/100
    end
    return temp
  end

# Concatenates  all the stock value arrays together with the dates
  def zippy(holdings,start_date,end_date)
    @stocks_values = []
    @all_dates = dates(start_date, end_date)

    holdings.each do |holding|
      json = quan(holding.symbol,start_date,end_date)
      @dates = date_array(json)
      value = value_array(json)
      @missing_dates = compare_json_dates_range_dates(@dates, @all_dates)
      create_value(@missing_dates, value)
      allocated = value_allocation(value,holding.allocation)
      @stocks_values << allocated
    end

    @total = @stocks_values.transpose.map {|x| x.reduce(:+)}
    @final = @all_dates.zip(@total)
    return @final
  end

# Just for the index. No concatenation
  def index_data(symbol, start_date, end_date)
    @all_dates = dates(start_date, end_date)
    json = quan(symbol,start_date,end_date)
    @dates = date_array(json)
    value = value_array(json)
    @missing_dates = compare_json_dates_range_dates(@dates, @all_dates)
    create_value(@missing_dates, value)
    @final = @all_dates.zip(value)
    return @final
  end

# Gives an array of all the days from start to end in [year month day] format
  def dates(start_date, end_date)
    @start = start_date.to_date
    @end = end_date.to_date
    @array_array_dates = []
    @range =  (@start..@end)

    @dates = @range.map do |date|
      @day = date.day
      @month = date.mon - 1
      @year = date.year
      date = []
      date << @year
      date << @month
      date << @day
      @array_array_dates << date
    end
    return @array_array_dates
  end

# Finds missing days index from the quandl data recieved
  def compare_json_dates_range_dates(quandl_dates, array_array_dates)
    need_value = []

    if array_array_dates.length != quandl_dates.length
      array_array_dates.each_with_index do |date, index|
        if !quandl_dates.include?(date)
          need_value <<  index
        end
      end
      return need_value
    else
      return need_value
    end
  end

# Creates values for those missing days, with the previous day's value
  def create_value(need_value, value_array)
    need_value.each do |index|
      if index == 0
        value_array.unshift(100)
      else
        value_array.insert(index, value_array[index -1])
      end
    end
    return value_array
  end

# Hold off from deleting
  # def hash_to_array(hash)
  #   array = []
  #   hash.each do |h|
  #     temp =[]
  #     h.each do |key,value|
  #       if key == "value"
  #         temp << value
  #       end
  #     end
  #     array <<temp
  #   end
  #   array.each do |a|
  #     a.delete_at(1)
  #     a.delete_at(1)
  #   end
  #   return array
  # end


  # def highchartarray(quan_result)
  #   data = []
  #   num_of_day = quan_result.length
  #   for i in 0..num_of_day-1
  #     datapoint = []
  #     datapoint.push(Date.UTC(quan_result[i]["date"].year, quan_result[i]["date"].month-1, quan_result[i]["date"].day))
  #     datapoint.push(quan_result[i]["value"])
  #     data.push(datapoint)
  #   end
  #   return data
  # end

end
