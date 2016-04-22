json.array!(@portfolios) do |portfolio|
  json.extract! portfolio, :id, :name, :user_id, :stock_id
  json.url portfolio_url(portfolio, format: :json)
end
