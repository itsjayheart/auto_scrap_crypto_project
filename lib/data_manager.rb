require 'pry'

file = File.open("database/crypto_data.md", "r")
file_data = file.read.tr("[\"]"," ").delete(",").split



def data_extract(file_data)
	puts "extracting data"
	data = []
	(file_data.length / file_data[0].to_i).times do
		puts "array[#{data.length + 1} length: #{file_data[0]}]"
		data.push([file_data.shift(file_data[0].to_i)])
	end
	puts "data extracted"

	return data
end

#data contains each scrapp in an array. ex: first scrapp is data[0]
#data[0] contains : data[0] == data.length ; data[1] == time when the scrapp happened ; each next data contains [*currency_abbreviation*, *money_value*]
#data = data_extract(file_data)
#data[0][2][0] == BTC
#data[0][2][1] == BTC.value
#data[*nb of the srapp*][*nb of the couple*][0==*currency_abbreviation*/1==*money_value*]


def create_daily_array(data)
	daily_BTC = []
	h = 0
	data.length.times do
		daily_BTC << data[h][0][4]
		h += 1
	end
	daily_BTC = [23,12,45,89,65,32,12,45,78,89,56,45,45,45,56,23,12,45,78,89,86,84,87,87]
	return daily_BTC
end


#gem whenever

####### my_crypto_algo.rb #######

#should be able to record cryptocurrencies prices
	# => every hour

#it should be able to put it into tables

#and to record for each day
	#which day
		# => it was the cheapest to buy
		# => it was the most pricey to sell
	#how much net profit it was
	#how much percentage of profit it was



def lowest_price_hour(array)
	return array.index { |x| x == array.min { |a, b| a <=> b }} + 1
end

def highest_relative_price_day(array)
	sliced_array = array.delete_if { |x| array.index { |y| y == x} <= array.index {|z| z == array.min { |a, b| a <=>b }}}
	return sliced_array.index { |zz| zz == sliced_array.max { |a, b| a <=> b }} + 1
end

def day_trader(array)
	return "the best day to buy is day number #{lowest_price_hour(array)} and the best day to sell is day number #{lowest_price_hour(array) + highest_relative_price_day(array)}"
end

def perform (file_data)
	data = data_extract(file_data)
	daily_BTC = create_daily_array(data)
	puts day_trader(daily_BTC)
end

perform(file_data)
