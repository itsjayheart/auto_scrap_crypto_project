require 'dotenv'
require 'nokogiri'
require 'pry'
require 'open-uri'


def create_key_array(page)
  key_array = []
  page.css('div#__next table tr td[3]').each do |el|
  	puts el.text
    key_array << el.text
  end
  return key_array
end

def create_value_array(page)
  value_array = []
  page.css('div#__next table tr td[5]').each do |el|
  	puts el.text
    value_array << el.text[1..-1].delete(",").to_f
  end
  return value_array
end

def compile_in_hash(key_array, value_array)
  result = []
  x = 0
  key_array.each do |key|
    mini_hash = Hash.new
    mini_hash[key] = value_array[x]
    x = x + 1
    puts mini_hash
    result << mini_hash
  end
  puts "Data compiled"
  return result
end

def save_data(data)
	save_date = "[#{Time.new.inspect.to_s.slice(0, 19).to_s}]"
	system("git add database/crypto_data#{save_date}.md")
	system("git commit -m 'scrap_save_#{save_date}'")
	system("git push origin master")
	puts "Commit pushed to github."
	File.write("database/crypto_data#{save_date}.md", "#{data}", mode: "w")
	puts "Data saved in database/crypto_data#{save_date}.md"
end

def perform(page)
  	system("echo \"\e[36mLOADING, keys...\e[0m\"")
	key_array = create_key_array(page)
  	system("echo \"\e[36mLOADING, values...\e[0m\"")
	value_array = create_value_array(page)
	system("echo \"\e[36mLOADING, compling data...\e[0m\"")
	crypto_data = compile_in_hash(key_array, value_array)
	system("echo \"\e[36mLOADING, saving data...\e[0m\"")
	save_data(crypto_data)
end

page = (Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))

perform(page)

puts = "source : #{page}"


