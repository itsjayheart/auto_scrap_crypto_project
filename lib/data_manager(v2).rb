require 'pry'

def load_file(file)
	return data_array = file.read.delete("[\"]").split
end

def extract_data(data)
	date = data[-2..-1]
	data = data[0..-3]
	key_array = []
	value_array = []
	data.each do |e|
		if data.index(e).odd?
			value_array << e
		elsif data.index(e).even?
			key_array << e
		end
	end
	return key_array, value_array, date
end



def load_file(file)
	data_array = load_file(file)
	data_extracted = extract_data(data_array)
	return data_extracted(value: 1), data_extracted(value: 2), data_extracted(value: 3)
end

def load_database
	x = 0
	key_database = []
	value_database = []
	date_database = []
	file = File.open("database/crypto_data_#{x}.md", "r")
	while date_database.length <= 100 do
		file_keys_values_dates = load_file(file)
		x = x + 1
		key_database << file_keys_values_dates(value: 1)
		value_database << file_keys_values_dates(value: 2)
		date_database << file_keys_values_dates(value: 3)
		puts x
	end
end


load_database
