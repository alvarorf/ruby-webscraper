require 'nokogiri'
require 'open-uri'
require 'histogram/array'
require 'ascii_charts'
require './Enumerables.rb'
require './lib/main_logic.rb'

class Scraper
  attr_accessor @doc, @price, @shipping, @total
  def initialize(search, lh_fs=0, cust = 0, lh_item_condition, min_price=0, max_price=999999999)
    if cust == 1
      url = "https://www.ebay.com/sch/i.html?_ipg=200&_fcse=10|42|43&LH_ItemCondition=#{lh_item_condition}&LH_FS=#{delivery_options}&_sop=15&_udlo=#{price_low}&_udhi=#{price_high}&_nkw=#{search}"
    else
      url = "https://www.ebay.com/sch/i.html?_ipg=200&_fcse=10|42|43&LH_ItemCondition=0|1000|1500|2000|2500|3000|7000&LH_FS=0&_sop=15&_nkw=#{search}"
    end
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
