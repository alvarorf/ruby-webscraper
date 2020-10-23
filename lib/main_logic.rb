require 'cgi'
class MainLogic
  def map_customized_options(cust)
    unless cust.zero?
      delivery_option, item_condition, min_price, max_price = customized_search(cust)
      lh_fs = (delivery_option[0].zero? || delivery_option == '' ? 0 : 1)
      lh_fs = 0
      lh_item_condition = case item_condition
                          when 1 then 1000
                          when 2 then 1500
                          when 3 then 2000
                          when 4 then 2500
                          when 5 then 3000
                          when 6 then 7000
                          when 7 then 0
                          else '0|1000|1500|2000|2500|3000|7000'
                          end
    end
    return lh_fs, lh_item_condition, min_price, max_price
  end

  def validate_search_keywords(keywords)
    while keywords.length < 3 || keywords == ''
      print 'Please enter a valid search string (non-empty and length >= 3): '
      keywords = gets.chomp
    end
    CGI.escape(keywords)
  end

  def validate_search_type(search_type)
    ops = [0, 1]
    unless ops.include?(search_type.to_i)
      print 'Please enter a valid search type. 0: Standard 1: Customized'
      search_type = gets.chomp
    end
    search_type
  end

  private

  def validate_delivery_options(del_option)
    options = [0, 1, 2]
    until options.include?(del_option.to_i)
      print 'Please enter a valid option. (0: to skip this step. 1: No free shipping, 2: Free shipping) '
      del_option = gets.chomp
    end
    del_option
  end

  def validate_item_condition(item_cond_option)
    options = [0, 1, 2, 3, 4]
    until options.include?(item_cond_option.to_i)
      print 'Please enter a valid option for the item condition'
      puts '(1: New, 2:Used, 3: Certified Refurbished, 4: Seller Refurbished, 5: Other or not specified )'
      item_cond_option = gets.chomp
    end
    item_cond_option
  end

  def validate_price_range_choice(price_range_choice)
    options = ['', 0, 1, 'y', 'yes']
    until options.include?(price_range_choice.to_i)
      puts 'Please enter a valid choice'
      puts 'Do you wish to specify a price range?(0 or empty: To skip, 1 or y: Yes)'
      price_range_choice = gets.chomp
    end
    price_range_choice
  end

  def validate_min_price
    puts 'Please enter a minimum price(>=0)'
    min_price = gets.chomp
    while min_price.to_i.negative? || !min_price.scan(/\D/).empty?
      puts 'Please enter a valid minimum price(>=0)'
      min_price = gets.chomp
    end
    min_price
  end

  def validate_max_price
    puts 'Please enter a maximum price(>0)'
    max_price = gets.chomp
    while max_price.to_i <= 0 || !max_price.scan(/\D/).empty?
      puts 'Please enter a valid maximum price(>0)'
      max_price = gets.chomp
    end
    max_price
  end

  def customized_search(cust)
    delivery_option = 0, item_condition = 0, min_price = 0, max_price = 999_999_999
    unless cust.zero?
      print 'Do you wish to specify a delivery option (0 or empty: Any, 1: Free shipping)? '
      delivery_option = validate_delivery_options(gets.chomp).to_i
      puts 'Do you wish to search according to a specific item condition?'
      print "(0 or empty: To skip, 1: New, 2: Open-box, 3: Certified Refurbished, 4: Seller Refurbished, \n"
      print '5: Used, 6: Damaged, 7: Not specified ) '
      item_condition = validate_item_condition(gets.chomp).to_i
      print 'Do you wish to specify a price range?(0 or empty: To skip, 1 or y: Yes)'
      price_range_choice = gets.chomp.to_i
      choice_price_range = validate_price_range_choice(price_range_choice)
      ops = [1, 'y']
      if ops.include?(choice_price_range)
        min_price = validate_min_price
        max_price = validate_max_price
      end
    end
    return delivery_option, item_condition, min_price, max_price
  end
end
