require 'spreadsheet'
#require './Scraper.rb'
require 'csv'

# Begin Test
print "Spreadsheet Test\n"

# Create the rows to be inserted
tags = ['id', 'ebay_id' 'prices', 'shipping', 'item_name']

# Create a new Workbook
new_book = Spreadsheet::Workbook.new

# Create the worksheet
new_book.create_worksheet :name => 'data_1'

# Add row_1
new_book.worksheet(0).insert_row(0, tags)

# Write the file
if Dir.exists?('../exports')
  puts "In here..."
  new_book.write('../exports/test.xls')
else
  puts "Now, around here..."
  Dir.mkdir('../exports')
  new_book.write('../exports/test.xls')
end




require 'csv'
CSV.open("../exports/myfile.csv", "w") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
  # ...
end
