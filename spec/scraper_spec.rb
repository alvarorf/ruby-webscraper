require '../lib/scraper.rb'

describe '#show_stats' do
  it 'should call the show_7_number_summary method' do
    my_scrapper = Scraper.new('computer', lh_fs = 0, cust = 0, item_cond = 0, price_low = 0, price_high = 999_999_999)
    expect(my_scrapper).to receive(:show_7_number_summary)
    my_scrapper.show_stats
  end

  it 'should call the plot_histogram method' do
    my_scrapper = Scraper.new('computer', lh_fs = 0, cust = 0, item_cond = 0, price_low = 0, price_high = 999_999_999)
    expect(my_scrapper).to receive(:plot_histogram)
    my_scrapper.show_stats
  end
end
