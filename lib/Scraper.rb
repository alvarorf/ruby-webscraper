require 'nokogiri'
require 'open-uri'
require 'histogram/array'
require 'ascii_charts'
require './Enumerables.rb'
class Scraper
  def initialize(search_item)
    base_url = 
    #@doc = Nokogiri::HTML(URI.open(url))
  end

  def get_price_arr(doc)
  end

  def get_shipping_arr(doc)
  end

  def get_total_price_arr(price)
  end

  def data_sanitizer(data)
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








=begin
  def calculate_bins(prices)
    mid = median(prices)
    n = prices.length
    if prices.length.even?
      subarray1 = prices[0..((n/2)-1)]
      subarray2 = prices[((n/2))..-1]
    else
      subarray1 = prices[0..((n/2))]
      subarray2 = prices[((prices.length/2))..-1]
    end
    q1 = median(subarray1)
    q3 = median(subarray2)
    iqr = q3 - q1
    h = 2*iqr*(n**(1/3))
    puts "h is: #{h}"
    puts "prices.max is : #{prices.max}"
    puts "prices.min is : #{prices.min}"
    return ((prices.max - prices.min) / h).round
  end
=end

  def prepare_histogram_array(bins, freqs)
    bins.each{|el| el.round(2)}
    freqs.each{|el| el.round(2)}
    return bins.zip(freqs)
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
