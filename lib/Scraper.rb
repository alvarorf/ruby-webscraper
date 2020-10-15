require 'nokogiri'
require 'open-uri'
require 'histogram/array'
require 'ascii_charts'
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

  def mean(arr)
    return arr.sum / arr.length
  end

  def median(prices)
    prices = prices.sort
    if prices.length.odd?
      return prices[prices.length/2].to_f
    else
      return ((prices[prices.length/2]+prices[(prices.length/2)-1])/2).to_f
    end
  end

  def sample_stdev(prices)
    x = mean(prices)
    sum_squares = 0
    prices.each {|el| sum_squares += (el - x)**2}
    sample_variance = sum_squares / (prices.length - 1)
    return Math.sqrt(sample_variance)
  end

  def max_min(prices)
    return prices.min, prices.max
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
puts "Prices are: #{prices}"
 new_scraper = Scraper.new
 puts "Median: #{new_scraper.median(prices)}"
 puts "Mean: #{new_scraper.mean(prices)}"
 puts "Stdev: #{new_scraper.sample_stdev(prices)}"
 puts "The histogram is: "
 #puts new_scraper.calculate_bins(prices)
 #num_bins = new_scraper.calculate_bins(prices)
 (bins, freqs) = prices.histogram
 my_arr = new_scraper.prepare_histogram_array(bins, freqs)
 puts "The bins and freqs are: "
 puts bins, freqs
 my_chart = AsciiCharts::Cartesian.new(my_arr)
 my_chart.draw
