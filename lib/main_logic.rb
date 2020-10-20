require 'cgi'

  def validate_search_keywords(keywords)
    while keywords.length < 3 || keywords == ''
      print "Please enter a valid search string (non-empty and length >= 3): "
      keywords = gets.chomp
    end
    return CGI::escape(keywords)
  end

  def validate_search_type(search_type)
    while search_type != 0 || search_type != 1
      print "Please enter a valid search type. 0: Standard 1: Customized"
      search_type = gets.chomp
    end
    return search_type
  end

  def validate_delivery_options(del_option)
    options = [0, 1, 2]
    while !options.include?(del_option.to_i)
      puts "options.include?(del_option) is: #{options.include?(del_option)}"
      print "Please enter a valid option. (0: to skip this step. 1: No free shipping, 2: Free shipping) "
      del_option = gets.chomp
    end
    return del_option
  end

  def validate_item_condition(item_cond_option)
    options = [0, 1, 2, 3, 4]
    while !options.include?(item_cond_option.to_i)
      print "Please enter a valid option for the item condition"
      puts "(1: New, 2:Used, 3: Certified Refurbished, 4: Seller Refurbished, 5: Other or not specified )"
      item_cond_option = gets.chomp
    end
    return item_cond_option
  end

  def validate_price_range_choice(price_range_choice)
    options=['', 0, 1, 'y', 'yes']
    while !options.include?(price_range_choice.to_i)
      puts "Please enter a valid choice"
      puts "Do you wish to specify a price range?(0 or empty: To skip, 1 or y: Yes)"
      price_range_choice = gets.chomp
    end
    return price_range_choice
  end

  def validate_min_price
    puts "Please enter a minimum price(>=0)"
    min_price = gets.chomp
    while min_price.to_i < 0 || !min_price.scan(/\D/).empty?
      puts "Please enter a valid minimum price(>=0)"
      min_price = gets.chomp
    end
    return CGI::escape(min_price)
  end

  def validate_max_price
    puts "Please enter a maximum price(>0)"
    max_price = gets.chomp
    while max_price.to_i <= 0 || !max_price.scan(/\D/).empty?
      puts "Please enter a valid maximum price(>0)"
      max_price = gets.chomp
    end
    return CGI::escape(max_price)
  end

  def customized_search
    print "Do you wish to specify a delivery option (0 or empty: Any, 1: Free shipping)?"
    delivery_option = validate_delivery_options(gets.chomp)
    puts "Do you wish to search according to a specific item condition?"
    print "(0 or empty: To skip, 1: New, 2: Open-box, 3: Certified Refurbished, 4: Seller Refurbished, \n"
    puts "5: Used, 6: Damaged, 7: Not specified )"
    item_condition = validate_item_condition(gets.chomp)
    puts "Do you wish to specify a price range?(0 or empty: To skip, 1 or y: Yes)"
    choice_price_range = validate_price_range_choice(price_range_choice = gets.chomp)
    if choice_price_range == 1 || choice_price_range == 'y'
      min_price = validate_min_price
      max_price = validate_max_price
    end
    return delivery_option.to_i, item_condition.to_i, choice_price_range, min_price, max_price
  end

  def map_customized_options
    delivery_option, item_condition, choice_price_range, min_price, max_price = customized_search
    (delivery_option == 0 || delivery_option == '') ? lh_fs = 0 : lh_fs = 1
    case item_condition
      when 1
        lh_item_condition = 1000
      when 2
        lh_item_condition = 1500
      when 3
        lh_item_condition = 2000
      when 4
        lh_item_condition = 2500
      when 5
        lh_item_condition = 3000
      when 6
        lh_item_condition = 7000
      when 7
        lh_item_condition = 0
      else
        lh_item_condition = '0|1000|1500|2000|2500|3000|7000'
    end
    return lh_fs, lh_item_condition, min_price, max_price
  end

map_customized_options

#puts "IN MAIN LOGIC"
