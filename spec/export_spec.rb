require_relative '../lib/export.rb'
require 'stringio'

describe Export do
  describe '#initialize' do
    it "After initializing, the 'price' class variable should not be empty" do
      my_scrapper = Scraper.new('computer', lh_fs = 0, cust = 0, item_cond = 0, price_low = 0, price_high = 999_999_999)
      my_export = Export.new(my_scrapper)
      expect(my_export.price).to_not eq('')
    end
  end

  describe '#export_data' do
    it 'The user interaction method should return 0 if 0 was given as an argument' do
      my_scrapper = Scraper.new('computer', lh_fs = 0, cust = 0, item_cond = 0, price_low = 0, price_high = 999_999_999)
      my_export = Export.new(my_scrapper)
      expect(my_export.export_data(0)).to eq(0)
    end
  end
end
