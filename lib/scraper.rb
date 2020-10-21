require 'ascii_charts'
require 'nokogiri'
require 'open-uri'
require 'histogram/array'
require '../lib/enumerable.rb'

# require 'ascii_charts'
# require './enumerable.rb'
# require './main_logic.rb'

class Scraper
  attr_accessor :doc, :price, :shipping
  # @price, @shipping, @total
  def initialize(search, lh_fs, cust, price_low, price_high, item_cond = 0)
    base_url = 'https://www.ebay.com/sch/i.html?_ipg=200'
    cust_search = "&LH_ItemCondition=#{item_cond}&LH_FS=#{lh_fs}&_sop=15&_udlo=#{price_low}&_udhi=#{price_high}"
    standard_search = '&LH_ItemCondition=0|1000|1500|2000|2500|3000|7000&LH_FS=0&_sop=15'
    keywords = "&_nkw=#{search}"
    min_max_price = "&_udlo=#{price_low}&_udhi=#{price_high}"
    url = (cust == 1 ? base_url.concat(cust_search, keywords) : base_url.concat(standard_search, keywords))
    @doc = Nokogiri::HTML(URI.open(url))
  end

  def show_stats
    data = price_and_shipping
    puts 'A statistical summary of the data is shown: '
    show_7_number_summary(data)
    puts 'A histogram of the data is shown: '
    plot_histogram(data)
  end

  private

  def price_arr
    @price = @doc.xpath("//span[@class='s-item__price']")
    @price = @price.map(&:text)
    return clean_data(@price).map(&:to_f)
  end

  def shipping_arr
    @shipping = @doc.xpath("//span[@class='s-item__shipping s-item__logisticsCost']")
    @shipping = @shipping.map(&:text)
    return clean_data(@shipping).map(&:to_f)
  end

  def title_arr(doc)
    @title = doc.xpath("//h3[@class='s-item__title']")
    return @title.map(&:text)
  end

  def item_condition(doc)
    @item_condition = doc.xpath("//span[@class='SECONDARY_INFO']")
    return @item_condition.map(&:text)
  end

  def purchase_options(doc)
    @pur_options = doc.xpath("//span[@class='s-item__purchase-options-with-icon']")
    return @pur_options.map { |el| el = (el.text.include?('!') ? 'Buy it now' : 'Best offer') }
  end

  def item_images(doc)
    @images = doc.xpath("//img[@class='s-item__image-img']")
    return @images.map { |el| el['src'] }
  end

  def other_info(doc)
    @other_info = doc.xpath("//div[@class='s-item__subtitle']")
    return @other_info.map(&:text)
  end

  def price_and_shipping
    @price = price_arr
    @shipping = shipping_arr
    return @price.zip(@shipping.cycle).map(&:sum)
  end

  def clean_data(data)
    return data.map { |el| el.delete('^0-9.') }
  end

  def prepare_histogram_array(bins, freqs)
    bins = bins.map { |el| el.round(1) }
    freqs = freqs.map { |el| el.round(1) }
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
    bins_freqs = prepare_histogram_array(bins, freqs)
    my_chart = AsciiCharts::Cartesian.new(bins_freqs)
    puts my_chart.draw
  end
end
