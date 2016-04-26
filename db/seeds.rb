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




#Test for chart data
    # @all_dates = dates("2015/01/01", "2015/01/09")

    # @json1 = [{"date" => "", "adj_close"=> "", "change"=>"", "value"=>100, "year"=>2015, "month"=>0, "day"=>1},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>95, "year"=>2015, "month"=>0, "day"=>2},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>90, "year"=>2015, "month"=>0, "day"=>3},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>85, "year"=>2015, "month"=>0, "day"=>4},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>75, "year"=>2015, "month"=>0, "day"=>6},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>70, "year"=>2015, "month"=>0, "day"=>7},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>65, "year"=>2015, "month"=>0, "day"=>8},
    # {"date" => "", "adj_close"=> "", "change"=>"", "value"=>60, "year"=>2015, "month"=>0, "day"=>9}]

    # @json2 = [{"date" => "", "adj_close"=> "", "change"=>"", "value"=>100, "year"=>2015, "month"=>0, "day"=>1},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>90, "year"=>2015, "month"=>0, "day"=>3},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>85, "year"=>2015, "month"=>0, "day"=>4},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>80, "year"=>2015, "month"=>0, "day"=>5},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>75, "year"=>2015, "month"=>0, "day"=>6},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>70, "year"=>2015, "month"=>0, "day"=>7},
    # {"date" => "", "adj_close"=> "", "change"=>"", "value"=>60, "year"=>2015, "month"=>0, "day"=>9}]

    # @json3 = [{"date" => "", "adj_close"=> "", "change"=>"", "value"=>100, "year"=>2015, "month"=>0, "day"=>1},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>95, "year"=>2015, "month"=>0, "day"=>2},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>90, "year"=>2015, "month"=>0, "day"=>3},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>85, "year"=>2015, "month"=>0, "day"=>4},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>80, "year"=>2015, "month"=>0, "day"=>5},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>75, "year"=>2015, "month"=>0, "day"=>6},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>70, "year"=>2015, "month"=>0, "day"=>7},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>65, "year"=>2015, "month"=>0, "day"=>8},
    # {"date" => "", "adj_close"=> "", "change"=>"", "value"=>60, "year"=>2015, "month"=>0, "day"=>9}]

    # @date1 = date_array(@json1)
    # @date2 = date_array(@json2)
    # @date3 = date_array(@json3)

    # value1 = value_array(@json1)
    # value2 = value_array(@json2)
    # value3 = value_array(@json3)

    # @missing_date1 = compare_json_dates_range_dates(@date1, @all_dates)
    # create_value(@missing_date1, value1)
    # @missing_date2 = compare_json_dates_range_dates(@date2, @all_dates)
    # create_value(@missing_date2, value2)
    # @missing_date3 = compare_json_dates_range_dates(@date3, @all_dates)
    # create_value(@missing_date3, value3)

    # allocated1 = value_allocation(value1,33.33)
    # allocated2 = value_allocation(value2,33.33)
    # allocated3 = value_allocation(value3,33.33)

    # @stocks_values << allocated1
    # @stocks_values << allocated2
    # @stocks_values << allocated3
