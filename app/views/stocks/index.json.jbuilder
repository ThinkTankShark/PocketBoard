json.array!(@stocks) do |stock|
  json.extract! stock, :id, :symbol, :name, :description, :request_token, :request_key
  json.url stock_url(stock, format: :json)
end
