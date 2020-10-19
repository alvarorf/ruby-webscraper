module Enumerable
  def mean
    puts "In here..."
      return self.sum / self.length
  end

  def median
    self.sort
    if self.length.odd?
      return self[self.length/2].to_f
    else
      return ((self[self.length/2]+self[(self.length/2)-1])/2).to_f
    end
  end

  def sample_stdev
    x = self.mean
    sum_squares = 0
    self.each {|el| sum_squares += (el - x)**2}
    sample_variance = sum_squares / (self.length - 1)
    return Math.sqrt(sample_variance)
  end

  def max_min
    return self.min, self.max
  end
end
