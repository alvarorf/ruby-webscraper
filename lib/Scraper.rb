require 'nokogiri'
require 'open-uri'
class Scraper
  def initialize(url='')
    #@doc = Nokogiri::HTML(URI.open(url),Encoding::UTF_8.to_s)
  end

  def get_price_arr(doc)
  end

  def get_shipping_arr(doc)
  end

  def get_total_price_arr(price)
  end

  def price_sanitizer(price)
    result = price.text.strip.sub!('Â','').gsub!("COP", "").gsub!(/[$,]/,'').gsub!(/\s+/, '').delete!("\u00A0")
    return result
  end

  def convert_to_f(arr)
    for i in 0...arr.length
      arr[i] = arr[i].to_f
    end
    return arr
  end


  def mean(prices)

  end

  def median(prices)
    prices = prices.sort
    #prices = convert_to_f(prices)
    puts "Prices are: #{prices}"
    if prices.length.odd?
      return prices[prices.length/2].to_f
    else
      return ((prices[prices.length/2]+prices[(prices.length/2)-1])/2).to_f
    end
  end

  def std_dev(prices)
  end

  def max_min(prices)
  end
end
prices = [1, 3, 4, 6, 7, 8, 9, 20]
 new_scraper = Scraper.new
 puts new_scraper.median(prices)
