# Ebay Webscraper

![screenshot](/images/screenshot.png)

> Welcome to my **Ebay Ruby Web scraper** built mainly with `Ruby` and `nokogiri`, but also using `rspec`, `simplecov` for testing and the `spreadsheet` gem for exporting to an excel file. Please enjoy and leave a comment.

The basic idea of the project is to collect data from www.ebay.com, based on the user's suggested keywords, and perform a basic statistical analysis on the pricing data (min, max, standard deviation, quartile 1, quartile 3, median, mean, and a histogram).
After the analysis is finished and its results are showed on the screen, the user is prompted to 'export' the data (in .xls format), if he/she wishes to do so, for further processing in some other statistical software.

As for the statistical analysis, it is performed in the `Enumerable` module, from `/lib/enumerable`. In here, I have three functions:
- `mean`: Which will return the mean of an Array.
- `find_perc(perc)`: This is used several times to find the first quartile (Q1, `find_perc(0.25)`), the median (Q2, `find_perc(0.5)`) and the third quartile (Q3, `find_perc(0.75)`). Each quartile returns a value which represents that specific quartile. So, for instance for Q1, if `find_perc(0.25)` returns 100000, it means that 25% of the data in that specific array are to the left or below 100000.
- `sample_stdev`: It is the square root of the variance. It is a measure of the dispersion of the data. The higher the value returned, the higher the dispersion in the data. So, for instance `[1, 1, 1, 1].sample_stdev` will return zero because, since all of the elements are the same, variance in the data is zero (therefore its square root, the standard deviation, will also be zero).

### Built With

- Ruby
- Nokogiri
- Rspec
- Simplecov
- Visual Studio Code
- Linux

### Setup

NOTE: You need to have `Bundler` installed and, of course, `Ruby`. If don't have `Bundler` installed you can install it with `gem install bundler`.

Assuming that `Bundler` is installed, you can continue with the following steps:
- Step 1: Clone this repository. Just use: `git clone https://github.com/alvarorf/ruby-webscraper`.
- Step 2: Open the project folder where the repository was downloaded. Once you are in that folder, open a terminal and make sure that it will be opened in that specific folder.
- Step 3: Once you are in the terminal, just type in: `bundle install`. This will install the required dependencies for this project.
- Step 4: Now, you can just run the project. Just move (or `cd`) into the bin folder (from within the terminal), and type in: `ruby main.rb`.
- Step 5 (Optional): To test the project

### Author

👤 **Alvaro Ruiz**

- Github: [@alvarorf](https://github.com/alvarorf)
- Twitter: [@aaruizf](https://twitter.com/aaruizf)
- Linkedin: [Álvaro Ruiz](https://www.linkedin.com/in/alvaro-andr%C3%A9s-ruiz-22810915a/)

### 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

### Show your support

Give a ⭐️ if you like this project!


### 📝 License

This project is for microverse course purposes.
