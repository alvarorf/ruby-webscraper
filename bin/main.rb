#require_relative '../lib/Scraper.rb'
require 'cgi'
require 'nokogiri'
require 'open-uri'
items_per_page = '_ipg=25, _ipg=50, _ipg=200'
page_number = '_pgn=2'
best_match_newly_listed = '_sop=10'
delivery_options_any = 'LH_FS=0'
delivery_options_free_international_shipping = 'LH_FS=1'
item_condition_not_specified ='LH_ItemCondition=0'
auction = 'LH_Auction=1'
buy_it_now = 'LH_BIN=1'
item_condition_new = 'LH_ItemCondition=1000'
item_condition_open_box = 'LH_ItemCondition=1500'
item_condition_certified_refurbished = 'LH_ItemCondition=2000'
item_condition_seller_refurbished = 'LH_ItemCondition=2500'
item_condition_used = 'LH_ItemCondition=3000'
item_condition_for_parts_or_not_working = 'LH_ItemCondition=7000'
under_a_certain_price = '_udhi=268%2C199' # under 268,199
between_a_certain_price_range = '_udlo=268%2C199&_udhi=689%2C655'
search_words = '_nkw=computer+desk'
search_first = 'https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2380057.m570.l1313&_nkw=shirt&_sacat=0'
search_after = 'https://www.ebay.com/sch/i.html?_from=R40&_nkw=shirt&_sacat=0'
my_var = "hello guys!"
new_var = CGI::escape(my_var)
puts new_var

show_seller_name = '&_fcse=10|42|43'
base_url = 'https://www.ebay.com/sch/i.html?'

puts "Welcome to my Ebay Web Scraper."

doc = Nokogiri::HTML(URI.open("https://www.ebay.com/sch/i.html?&_nkw=computer")) # Encoding::UTF_8.to_s
to_select = "s-item__price"
to_select2 = 'div[class="s-item__price"]'
price = doc.xpath("//span[@class='s-item__price']")
shipping = doc.xpath("//span[@class='s-item__shipping s-item__logisticsCost']")
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

shipping1 = shipping[1].text.strip.sub!('Â','').gsub!("COP", "").gsub!(/[$,]/,'').gsub!(/\s+/, '').delete!("\u00A0")
puts "shipping1, pre gsub: #{shipping1}"
#attempt1 shipping1 = shipping[1].text.gsub("[^0-9.-]",'')
#attempt2
shipping1 = shipping[1].text.delete('^0-9.')
price1 = price[1].text.delete('^0-9.')
puts "shipping1, post gsub #{shipping1}"
puts "price[1] is: #{price1}"
puts "shipping[1] is: #{shipping1} \s\n"
#puts price[1]
puts "\u00A0"
encoded_text = 'COP $538&Acirc;&nbsp;100.81'
decoded_text = CGI::unescape(encoded_text)
puts decoded_text
puts "The doc is"
#puts doc
#puts doc
