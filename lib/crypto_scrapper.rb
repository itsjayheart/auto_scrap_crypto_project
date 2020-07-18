require 'dotenv'
require 'nokogiri'
require 'pry'
require 'open-uri'


def create_key_array(page)
  key_array = []
  page.css('div#__next table tr td[3]').each do |el|
  	puts el.text
    key_array.push(el.text)
  end
  return key_array
end

def create_value_array(page)
  value_array = []
  page.css('div#__next table tr td[5]').each do |el|
  	puts el.text
    value_array.push(el.text[1..-1].delete(","))
  end
  return value_array
end

def compile_data(key_array, value_array)
  compiled_data = []
  compiled_data = key_array.zip(value_array)
  save_date = Time.new.inspect.to_s.slice(0, 19).to_s
  compiled_data.unshift(save_date)
  compiled_data.unshift(compiled_data.flatten.length + 2)
  puts compiled_data
  puts "\nData compiled"
  return compiled_data
end

def save_data(data)
	File.write("database/crypto_data.md", "#{data}", mode: "a")
	puts "Data saved in database/crypto_data.md"
	#desactivated|____________________________________________
	#system("git add 'database/crypto_data#{save_date}.md'") |
	#system("git commit -m 'auto_scrap_commit'")			 |
	#system("git push origin master")						 |
	#puts "Commit pushed to github."						 |
end

def perform(page)
  	system("echo \"\e[36mLOADING, keys...\e[0m\"")
	key_array = create_key_array(page)
  	system("echo \"\e[36mLOADING, values...\e[0m\"")
	value_array = create_value_array(page)
	system("echo \"\e[36mLOADING, compling data...\e[0m\"")
	crypto_data = compile_data(key_array, value_array)
	system("echo \"\e[36mLOADING, saving data...\e[0m\"")
	save_data(crypto_data)
end

page = (Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))
x = 0
loop do
  perform(page)
  puts "scrap number #{x} was done, please wait for 1 hour"
  x = x + 1
  sleep(3600)
end

puts = "source : #{page}"
