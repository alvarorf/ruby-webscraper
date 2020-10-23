require 'cgi'
require 'nokogiri'
require 'open-uri'
require_relative '../lib/main_logic.rb'
require_relative '../lib/scraper.rb'
require_relative '../lib/export.rb'

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
  print 'Would you like to export the results of this session?(0 or another character: No, 1: Yes) '
  exp = gets.chomp.to_i
  if exp == 1
    new_export = Export.new(search_obj)
    new_export.export_data(exp)
  end
  puts 'Would you like to perform another search? (O or else: No, 1: Yes)'
  ans = gets.chomp.to_i
  break unless ops.include?(ans)
end
