require 'spreadsheet'
require 'csv'
require '../lib/scraper.rb'

# Begin Test
print "Spreadsheet Test\n"
# Create a new Workbook

class Export
  def prepare_data(scraper_instance)
    @price, @ship, @title, @i_condition, @pur_option, @images, @other = scraper_instance.return_data
    @tags = %w[prices shipping item_name item_condition purchase_options image other_info]
    @price = @price.unshift(@tags[0])
    @ship = @ship.unshift(@tags[1])
    @title = @title.unshift(@tags[2])
    @i_condition = @i_condition.unshift(@tags[3])
    @pur_option = @pur_option.unshift(@tags[4])
    @images = @images.unshift(@tags[5])
    @other = @other.unshift(@tags[6])
  end

  def insert_data
    new_book = Spreadsheet::Workbook.new
    new_book.worksheet(0).insert_row(0, @price)
    new_book.worksheet(0).insert_row(1, @ship)
    new_book.worksheet(0).insert_row(2, @title)
    new_book.worksheet(0).insert_row(3, @i_condition)
    new_book.worksheet(0).insert_row(4, @pur_option)
    new_book.worksheet(0).insert_row(5, @images)
    new_book.worksheet(0).insert_row(6, @other)
  end
end

# Create the rows to be inserted
# tags = %w[id prices shipping item_name item_condition purchase_options image other_info]

# Create the worksheet
# sheet1 = new_book.create_worksheet name: 'data_1'
# sheet = new_book.create_worksheet

# Add row_1

# ADD row_2
# price[0]
# sheet.row(1).push 'Charles Lowe', 'Author of the ruby-ole Library'

# Write the file
Dir.mkdir('../exports') unless Dir.exist?('../exports')

new_book.write('../exports/results.xls')

CSV.open('../exports/myfile.csv', 'w') do |csv|
  csv << %w[row of CSV data]
  csv << %w[another row]
end
