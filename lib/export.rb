require 'spreadsheet'
require 'csv'

# Begin Test
print "Spreadsheet Test\n"

# Create the rows to be inserted
tags = %w[id ebay_id prices shipping item_name]

# Create a new Workbook
new_book = Spreadsheet::Workbook.new

# Create the worksheet
new_book.create_worksheet name: 'data_1'

# Add row_1
new_book.worksheet(0).insert_row(0, tags)

# Write the file
unless Dir.exist?('../exports')
  Dir.mkdir('../exports')
end

new_book.write('../exports/test.xls')

CSV.open('../exports/myfile.csv', 'w') do |csv|
  csv << %w[row of CSV data]
  csv << %w[another row]
end
