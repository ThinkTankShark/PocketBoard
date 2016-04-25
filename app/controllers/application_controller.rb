class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

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
















end
