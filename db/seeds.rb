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
    name: sector,
    description: Faker::Lorem.sentences(3)
    })
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


