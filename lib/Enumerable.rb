module Enumerable
  def mean
      return self.sum / self.length
  end
  
  def find_perc(k)
    n = self.length
    index = k*n
    data = self.sort
    if (index % 1) != 0
      result = data[index.round-1].to_f
    else
      result = (data[index-1].to_f+data[index].to_f)/2
    end
  end

  def sample_stdev
    x = self.mean
    sum_squares = 0
    self.each {|el| sum_squares += (el - x)**2}
    sample_variance = sum_squares / (self.length - 1)
    return Math.sqrt(sample_variance)
  end
end

my_data=[43, 54, 56, 61, 62, 66, 68, 69, 69, 70, 71, 72, 77, 78, 79, 85, 87, 88, 89, 93, 95, 96, 98, 99, 99]
puts my_data.find_perc(0.5)
my_data2 = [1, 2, 3, 4, 5, 6, 8, 9]
puts my_data2.find_perc(0.5)#median
my_data3 = [0, 1, 2, 3, 4, 5, 6, 7]
puts my_data3.find_perc(0.5)
