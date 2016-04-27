module PortfoliosHelper
  def api
    result = RestClient.get "http://api.nytimes.com/svc/search/v2/articlesearch.json?callback=svc_search_v2_articlesearch&q=finance&begin_date=20140101&end_date=20150101&sort=oldest&#{ENV['NYTIME_KEY']}"
    parsed = JSON.parse(result)
  end

end
