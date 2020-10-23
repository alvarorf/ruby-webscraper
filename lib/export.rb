require 'spreadsheet'
require 'csv'
require '../lib/scraper.rb'

class Export
  attr_reader :price, :ship, :title, :i_condition, :pur_option, :images
  def initialize(scraper_instance)
    @price, @ship, @title, @i_condition, @pur_option, @images = scraper_instance.return_data
  end

  def user_interaction
    print 'Would you like to export the results of this session?(0 or another character: No, 1: Yes) '
    exp = gets.chomp.to_i
    if exp == 1
      prepare_data
      insert_data
      puts 'The data has been saved in exports/results.xls'
    end
    puts 'Would you like to perform another search? (O or else: No, 1: Yes)'
    reply = gets.chomp
    return reply.to_i
  end

  def prepare_data
    @tags = %w[prices shipping item_name item_condition purchase_options image]
    @price = @price.unshift(@tags[0])
    @ship = @ship.unshift(@tags[1])
    @title = @title.unshift(@tags[2])
    @i_condition = @i_condition.unshift(@tags[3])
    @pur_option = @pur_option.unshift(@tags[4])
    @images = @images.unshift(@tags[5])
  end

  def insert_data
    new_book = Spreadsheet::Workbook.new
    new_book.create_worksheet name: 'value'
    new_book.worksheet(0).insert_row(0, @price)
    new_book.worksheet(0).insert_row(1, @ship)
    new_book.worksheet(0).insert_row(2, @title)
    new_book.worksheet(0).insert_row(3, @i_condition)
    new_book.worksheet(0).insert_row(4, @pur_option)
    new_book.worksheet(0).insert_row(5, @images)
    Dir.mkdir('../exports') unless Dir.exist?('../exports')
    new_book.write('../exports/results.xls')
  end
end
