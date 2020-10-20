require '../lib/Enumerable.rb'
describe Enumerable do
  describe '#mean' do
    let(:new_arr) { [1, 6, 8, 10, 15] }
    it 'Should return the mean of the array elements in the array(8)' do
      expect(new_arr.mean).to eql(8)
    end
  end

  describe '#find_perc' do
    let(:new_arr) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18] }
    it 'The percentile 50 should be equal to the median of the data(9.5)' do
      expect(new_arr.find_perc(0.5)).to eql(9.5)
    end
    it 'The percentile 25(Q1) should be equal to the median (perc. 50) of the first half of data(9.5)' do
      expect(new_arr.find_perc(0.25)).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9].find_perc(0.5))
    end
    it 'The percentile 75(Q3) should be equal to the median (perc. 50) of the second half of data(9.5)' do
      expect(new_arr.find_perc(0.75)).to eql([10, 11, 12, 13, 14, 15, 16, 17, 18].find_perc(0.5))
    end
  end

  describe '#sample_stdev' do
    let(:new_arr) { [1, 1, 1, 1, 1] }
    let(:example) { [3, 6, 9] }
    it 'Should be zero (0.0) if the elements in the array are identical' do
      expect(new_arr.sample_stdev).to eql(0.0)
    end

    it 'Should return the sample standard deviation of the array(3.0)' do
      expect(example.sample_stdev).to eql(3.0)
    end
  end
end
