class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token  
  require 'uri'

  def yahoo_table(snp)
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
    end
    return nasdaq_result;
  end

  def stock_table(stock)
    stock_result = []
    stock.each_with_index do |d,t|
      stock_result[t] = {}
      stock_result[t]['date'] = stock[stock.length-t-1]['date']
      stock_result[t]['adj_close'] = stock[stock.length-t-1]['adj_close']

      unless t==0
        stock_result[t]['change'] = stock[stock.length-t-1]['adj_close']/stock[stock.length-t]['adj_close']-1
      else
        stock_result[t]['change'] = 0
      end

      if t == 0
        stock_result[t]['value'] = 100
      else
        stock_result[t]['value'] = stock_result[t-1]['value']*(1+stock_result[t]['change'])
      end
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
    # result = RestClient.get 'http://api.nytimes.com/svc/search/v2/articlesearch.json?callback=svc_search_v2_articlesearch&q=finance&begin_date=20140101&end_date=20150101&sort=oldest&api-key=4135b3b218606cfe437e454cea3fca0f%3A0%3A75109961'

    link = URI.escape("http://api.nytimes.com/svc/search/v2/articlesearch.json?q="+query+"&fq=news_desk:(\"Finance\",\"Business\",\"SundayBusiness\")&begin_date="+begin_date+"&end_date="+end_date+"&api-key=")
    link += ENV["NYTIMESKEY"]
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
      stock = Quandl::Dataset.get("WIKI/#{query}").data(params: { start_date: "#{start_date}", end_date: "#{end_date}" }) # ["date", "open", "high", "low", "close", "volume", "ex_dividend", "split_ratio", "adj_open", "adj_high", "adj_low", "adj_close", "adj_volume"]
      stock_result = stock_table(stock)
      return stock_result
    end
  end

  def highchartarray(quan_result)
    data = []
    num_of_day = quan_result.length
    for i in 0..num_of_day-1
      datapoint = []
      datapoint.push(Date.UTC(quan_result[i]["date"].year, quan_result[i]["date"].month-1, quan_result[i]["date"].day))
      datapoint.push(quan_result[i]["value"])
      data.push(datapoint)
    end
    return data
  end
end
