# result = RestClient.get 'http://api.nytimes.com/svc/search/v2/articlesearch.response-format?[q=<%= %>&fq=filter-field:(filter-term)&additional-params=values]&api-key=<%= ENV['API_KEY']%>'

result = RestClient.get 'http://api.nytimes.com/svc/search/v2/articlesearch.json?callback=svc_search_v2_articlesearch&q=finance&begin_date=20140101&end_date=20150101&sort=oldest&api-key=4135b3b218606cfe437e454cea3fca0f%3A0%3A75109961'
parsed = JSON.parse(result)
