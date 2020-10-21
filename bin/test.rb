require 'nokogiri'
require 'open-uri'

# url = 'https://www.ebay.com/sch/i.html?_ipg=200&_nkw=computer'
# doc = Nokogiri::HTML(URI.open(url))
class Scrappy
  attr_accessor :doc, :price
  def initialize
    url = 'https://www.ebay.com/sch/i.html?_ipg=200&_nkw=computer'
    @doc = Nokogiri::HTML(URI.open(url))
    # @price = @doc.xpath("//span[@class='s-item__price']")
  end

  def price_arr
    @price = @doc.xpath("//span[@class='s-item__price']")
    return clean_data(@price).map(&:to_f)
  end

  def clean_data(data)
    return data.map { |el| el.text.delete!('^0-9.') }
  end
end

=begin
def price_arr(doc)
  price = doc.xpath("//span[@class='s-item__price']")
  return clean_data(price).map(&:to_f)
end

def shipping_arr(doc)
  shipping = doc.xpath("//span[@class='s-item__shipping s-item__logisticsCost']")
  return clean_data(shipping).map(&:to_f)
end

def clean_data(data)
  return data.map { |el| el.text.delete!('^0-9.') }
end

def item_condition(doc)
  item_condition = doc.xpath("//span[@class='SECONDARY_INFO']")
  return item_condition.map { |el| el.text }
end

def purchase_options(doc)
  pur_options = doc.xpath("//span[@class='s-item__purchase-options-with-icon']")
  return pur_options.map { |el|  el = (el.text.include?('!') ? "Buy it now": "Best offer") }
end

def item_images(doc)
  images = doc.xpath("//img[@class='s-item__image-img']")
  return images.map { |el| el["src"] }
end

def other_info(doc)
  other_info = doc.xpath("//div[@class='s-item__subtitle']")
  return other_info.map { |el| el.text }
end

def price_and_shipping(price, shipping)
  return price.zip(shipping).each_with_object([]){ |( price, shipping ), m| m << price + shipping }
end

# my_var = title_arr(doc)
# puts my_var
puts "Another, try"
title2 = doc.xpath("//h3[@class='s-item__title']")
puts title2[0].text
puts "Now, the price data"
prices = price_arr(doc)
puts prices[0]
puts "Now, the shipping data"
shippings = shipping_arr(doc)
puts shippings[0]
# puts "Now, the item condition:"
# item_cond = item_condition(doc)
# puts item_cond
puts "Now, price and shipping: "
priceandship = price_and_shipping(prices, shippings)
puts priceandship[0]

# puts clean_data(["342342rtreegr","#544545"])
testing = ["342342rtreegr","#544545.06"]
testing.map { |el| el.delete!('^0-9.') }
# puts testing
=end

my_scraper = Scrappy.new
puts my_scraper.price_arr
# puts my_scraper.attributes
