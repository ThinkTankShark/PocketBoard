require 'csv'

sectors = [
"Basic Industries",
"Capital Goods",
"Consumer Durables",
"Consumer Non-Durables",
"Consumer Services",
"Energy",
"Finance",
"Health Care",
"Miscellaneous",
"Public Utilities",
"Technology",
"Transportation",
"n/a"
]


sectors.each do |sector|
  Industry.create({
    name: sector
    })
end


10.times do
  user = User.create({
    email: Faker::Internet.free_email,
    password: "test123"
    })

  2.times do

    portfolio = Portfolio.create({
      name: Faker::Lorem.word,
      user_id: user.id
      })


    3.times do
      holding = Holding.new({
        symbol: "AA",
        allocation: 0.35,
        stock_id: rand(50),
        portfolio_id: portfolio.id
        })
    end

  end

end

User.create(email:"test@gmail.com", password:"1234")


def parse_csv(file_path)
  csv = CSV.open(file_path, :headers => true)
  stock_arr = csv.map{|row| row.to_hash}
  return stock_arr
end

nasdaq_stocks = parse_csv('nasdaq.csv')

nasdaq_stocks.each do |stock|
  new_stock = Stock.new(symbol: stock["Symbol"],
   name: stock["Name"],
   sector: stock["Sector"])

  sector = Industry.find_by(name: "#{new_stock.sector}")
  sector.stocks << new_stock
  new_stock.save
end

StocksUser.create(user_id: 1, stock_id: 1)
StocksUser.create(user_id: 1, stock_id: 2)
StocksUser.create(user_id: 1, stock_id: 3)
StocksUser.create(user_id: 1, stock_id: 4)
