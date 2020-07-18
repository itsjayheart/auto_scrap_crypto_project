require 'pry'

file = File.open("database/crypto_data.md", "r")
file_data = file.read.tr("[\"]"," ").delete(",").split



def data_extract(file_data)
	puts "extrating data"
	data = []
	(file_data.length / file_data[0].to_i).times do
		puts "array[#{data.length + 1} length: #{file_data[0]}]"				
		data.push([file_data.shift(file_data[0].to_i)])
	end
	puts "data extrcated"
end

data_extract(file_data)

