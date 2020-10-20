require 'nokogiri'
require 'open-uri'
require 'histogram/array'
require 'ascii_charts'
require './Enumerables.rb'
require './lib/main_logic.rb'
class Scraper
  attr_accessor @doc, @price, @shipping, @total
  def initialize(base_url='',search, custom = 0, delivery_options, item_cond, price_low=0, price_high=999999999, delivery_options=0)
    if custom == 1
      base_url = "https://www.ebay.com/sch/i.html?_ipg=200&_fcse=10|42|43&LH_ItemCondition=#{item_cond}&LH_FS=#{delivery_options}&_sop=15&_udlo=#{price_low}&_udhi=#{price_high}&_nkw=#{search}"
    else
      base_url = "https://www.ebay.com/sch/i.html?_ipg=200&_fcse=10|42|43&LH_ItemCondition=0|1000|1500|2000|2500|3000|7000&LH_FS=0&_sop=15&_nkw=#{search}"
    end
      base_url='https://www.ebay.com/sch/i.html?_ipg=200&_fcse=10|42|43&LH_ItemCondition=0|1000|1500|2000|2500|3000|7000&LH_FS=0&_sop=15&_nkw=#{search}'
    base_url =
    @doc = Nokogiri::HTML(URI.open(url))
  end

  def get_price_arr
    @price = doc.xpath("//span[@class='s-item__price']")
    return clean_data(@price)
  end

  def get_shipping_arr
    @shipping = doc.xpath("//span[@class='s-item__shipping s-item__logisticsCost']")
    return clean_data(@shipping)
  end

  def get_total_price_arr
    @
  end

  def clean_data(data)
    i = 0
    for i in 0...data.length
      data[i].text.delete('^0-9.')
    end
    return data
  end

  def convert_to_f(arr)
    for i in 0...arr.length
      arr[i] = arr[i].to_f
    end
    return arr
  end

  def prepare_histogram_array(bins, freqs)
    bins.each{|el| el.round(2)}
    freqs.each{|el| el.round(2)}
    return bins.zip(freqs)
  end

  def plot_histogram
  end
end
prices = Array.new(200) { rand(1...200) }
puts "The mean is: #{prices.mean}"
puts "Prices are: #{prices}"
 new_scraper = Scraper.new
 puts "Median: #{prices.median}"
 puts "Mean: #{prices.mean}"
 puts "Stdev: #{prices.sample_stdev}"
 puts "The histogram is: "
 #puts new_scraper.calculate_bins(prices)
 #num_bins = new_scraper.calculate_bins(prices)
 (bins, freqs) = prices.histogram
 my_arr = new_scraper.prepare_histogram_array(bins, freqs)
 puts "The bins and freqs are: "
 puts bins, freqs
 my_chart = AsciiCharts::Cartesian.new(my_arr)
 my_chart.draw
