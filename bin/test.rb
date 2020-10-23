
require 'ascii_charts'
require 'nokogiri'
require 'open-uri'
require 'histogram/array'

class Scraper
  attr_reader :doc, :price, :shipping, :title, :item_condition, :pur_option, :images, :other_info

  def initialize(search, lh_fs, cust, price_low, price_high, item_cond = 0)
    base_url = 'https://www.ebay.com/sch/i.html?_ipg=200'
    cust_search = "&LH_ItemCondition=#{item_cond}&LH_FS=#{lh_fs}&_sop=15&_udlo=#{price_low}&_udhi=#{price_high}"
    standard_search = '&LH_ItemCondition=0|1000|1500|2000|2500|3000|7000&LH_FS=0&_sop=15'
    keywords = "&_nkw=#{search}"
    url = (cust == 1 ? base_url.concat(cust_search, keywords) : base_url.concat(standard_search, keywords))
    @doc = Nokogiri::HTML(URI.open(url))
    @images = @doc.xpath("//img[@class='s-item__image-img']").map { |el| el['src'] }
    @item_condition = @doc.xpath("//span[@class='SECONDARY_INFO']").map(&:text)
    @title = @doc.xpath("//h3[@class='s-item__title']").map(&:text)
  end
end

search = Scraper.new('laptop', lh_fs = 0, cust = 0, item_cond = 0, price_low = 0, price_high = 999_999_999)
puts "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
puts search.other_info
puts "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
