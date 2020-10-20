require 'nokogiri'
require 'open-uri'
require 'histogram/array'
# require 'ascii_charts'
# require './enumerable.rb'
# require './main_logic.rb'

class Scraper
  #attr_accessor @doc, @price, @shipping, @total
  def initialize(search, lh_fs, cust, item_cond, price_low, price_high)
    base_url = 'https://www.ebay.com/sch/i.html?_ipg=200'
    cust_search = "&LH_ItemCondition=#{item_cond}&LH_FS=#{delivery_options}&_sop=15&_udlo=#{price_low}&_udhi=#{price_high}"
    standard_search = '&LH_ItemCondition=0|1000|1500|2000|2500|3000|7000&LH_FS=0&_sop=15'
    keywords = "&_nkw=#{search}"
    min_max_price = "&_udlo=#{price_low}&_udhi=#{price_high}"
    item_cond = "&LH_ItemCondition=#{item_cond}"
    shipping = "&LH_FS=#{lh_fs}"
    url = (cust == 1 ? base_url.concat(cust_search, keywords) : base_url.concat(standard_search, keywords))
    @doc = Nokogiri::HTML(URI.open(url))
  end

  def price_arr
    @price = doc.xpath("//span[@class='s-item__price']")
    return clean_data(@price)
  end

  def shipping_arr
    @shipping = doc.xpath("//span[@class='s-item__shipping s-item__logisticsCost']")
    return clean_data(@shipping)
  end

  def clean_data(data)
    i = 0
    data.each { data[i].text.delete('^0-9.') }
    return data
  end

  def convert_to_f(arr)
    arr.each { arr[i] = arr[i].to_f }
    return arr
  end

  def prepare_histogram_array(bins, freqs)
    bins.each { |el| el.round(2) }
    freqs.each { |el| el.round(2) }
    return bins.zip(freqs)
  end

  def show_7_number_summary(data)
    puts "Min: #{data.min}"
    puts "Q1: #{data.find_perc(0.25)}"
    puts "Median: #{data.find_perc(0.5)}"
    puts "Mean: #{data.mean}"
    puts "Stdev: #{data.sample_stdev}"
    puts "Q3: #{data.find_perc(0.75)}"
    puts "Max: #{data.max}"
  end

  def plot_histogram(data)
    (bins, freqs) = data.histogram
    bins_freqs = new_scraper.prepare_histogram_array(bins, freqs)
    my_chart = AsciiCharts::Cartesian.new(bins_freqs)
    my_chart.draw
  end
end