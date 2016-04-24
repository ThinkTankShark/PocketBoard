json.array!(@stock_users) do |stock_user|
  json.extract! stock_user, :id, :user_id, :stock_id
  json.url stock_user_url(stock_user, format: :json)
end
