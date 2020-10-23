require 'cgi'
require 'nokogiri'
require 'open-uri'
require '../lib/main_logic.rb'
require '../lib/scraper.rb'
require '../lib/export.rb'

puts 'Welcome to my Ebay Web Scraper.'
loop do
  ops = [1, 'y']
  print 'Please enter the name of the item that you want to search: '
  logic = MainLogic.new
  search = logic.validate_search_keywords(gets.chomp)
  search = CGI.escape(search)
  print 'Would you like to perform a standard search (0) or a customized search(1)? '
  cust = logic.validate_search_type(gets.chomp.to_i)
  if cust.zero?
    search_obj = Scraper.new(search, lh_fs = 0, cust = 0, item_cond = 0, price_low = 0, price_high = 999_999_999)
  else
    lh_fs, lh_item_condition, min_price, max_price = logic.map_customized_options(cust)
    search_obj = Scraper.new(search, lh_fs, lh_item_condition, min_price, max_price)
  end
  search_obj.show_stats
  new_export = Export.new(search_obj)
  ans = new_export.user_interaction
  break unless ops.include?(ans)
end
