def stock_picker(stocks)
	profits = []
	buy_day = 0
	sell_day = 0
	stocks.each_with_index do |price1, day1|
		stocks.each_with_index do |price2, day2|
			if day2 > day1 && price2 > price1
				profit = stocks[day2] - price1
				profits.push(profit)
				if profit == profits.max
					buy_day = day1
					sell_day = day2
				end
			end
		end
	end
	print "The best day to buy is on day #{buy_day}; the best day to sell is on day #{sell_day}"
end
puts stock_picker([17,3,6,9,15,8,6,1,10])
puts "Enter stock prices separated by commas:"
stock_prices = gets.chomp.split(",").map { |price| price.to_i}
puts stock_picker(stock_prices)
