module Enumerable
  def mean
    sum / length
  end

  def find_perc(perc)
    n = length
    index = perc * n
    data = sort
    result = ((index % 1) != 0 ? data[index.round - 1].to_f : (data[index - 1].to_f + data[index].to_f) / 2)
  end

  def sample_stdev
    x = mean
    sum_squares = 0
    each { |el| sum_squares += (el - x)**2 }
    sample_variance = sum_squares / (length - 1)
    Math.sqrt(sample_variance)
  end
end
