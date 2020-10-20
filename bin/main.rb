#require_relative '../lib/Scraper.rb'
require 'cgi'
require 'nokogiri'
require 'open-uri'
require '../lib/main_logic.rb'
require '../lib/Scraper.rb'


puts "Welcome to my Ebay Web Scraper."
print "Please enter the name of the item that you want to search: "
search = validate_search_keywords(gets.chomp)
search = CGI::escape(search)
puts "Would you like to perform a standard search (0) or a customized search(1)?"
search_type = validate_search_type(gets.chomp)
if search_type == 0
  Scraper.new(search)
else
  lh_fs, lh_item_condition, choice_price_range, min_price, max_price = map_customized_options
  
end

doc = Nokogiri::HTML(URI.open("https://www.ebay.com/sch/i.html?_ipg=200&_fcse=10|42|43&LH_ItemCondition=0|1000|1500|2000|2500|3000|7000&LH_FS=0&_sop=15&_nkw=#{search}")) # Encoding::UTF_8.to_s
price = doc.xpath("//span[@class='s-item__price']")
shipping = doc.xpath("//span[@class='s-item__shipping s-item__logisticsCost']")
title = doc.xpath("//h3[@class='s-item__title']")
item_condition = doc.xpath("//span[@class='SECONDARY_INFO']")
purchase_options = doc.xpath("//span[@class='s-item__purchase-options-with-icon']")
item_hotness = doc.xpath("//span[@class='BOLD NEGATIVE']")
item_hotness2 = doc.xpath("//span[@class='s-item__hotness s-item__itemHotness']//span[@class='BOLD NEGATIVE']")
item_images = doc.xpath("//img[@class='s-item__image-img']")
#s-item__hotness s-item__itemHotness
other_info = doc.xpath("//div[@class='s-item__subtitle']")
#shipping = doc.at("s-item__price")
#puts shipping.is_a? Array
#puts "The price is: #{price}"
#price1 = price[1].text.strip.sub!('Â','').gsub!("COP", "").gsub!(/[$,]/,'').gsub!(/\s+/, '').delete!("\u00A0")
class_name = 's-item__shipping '
puts "Before..."
#puts doc.xpath("//*[contains('s-item__shipping')]")
#attempt1: shipping=doc.at('span:contains("s-item__shipping")')
#attempt2 shipping = doc.xpath('//span[//*[contains(text(), "shipping")]]')
#attempt3
#puts doc.at_css("span")

#shipping1 = shipping[1].text.strip.sub!('Â','').gsub!("COP", "").gsub!(/[$,]/,'').gsub!(/\s+/, '').delete!("\u00A0")
#puts "shipping1, pre gsub: #{shipping1}"
#attempt2
shipping1 = shipping[1].text.delete('^0-9.')
price1 = price[1].text.delete('^0-9.')
#puts price.mean()
puts "shipping1, post gsub #{shipping1}"
puts "price[1] is: #{price1}"
puts "shipping[1] is: #{shipping1} \s\n"
#puts price[1]
#puts "\u00A0"
#encoded_text = 'COP $538&Acirc;&nbsp;100.81'
#decoded_text = CGI::unescape(encoded_text)
#puts decoded_text
puts "Titles"
puts title[0].text
puts "Item Condition"
puts item_condition[0].text
puts "Item hotness"
puts item_hotness2.length
puts "Prices"
puts price.length
puts "Images"
puts item_images[0]['src']
#puts doc
#puts doc
