module FormHelper
  def setup_portfolio(portfolio)
    3.times { portfolio.holdings.build }
    portfolio
  end
end
