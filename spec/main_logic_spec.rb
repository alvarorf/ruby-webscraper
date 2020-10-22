require '../lib/main_logic.rb'

describe MainLogic do
  describe '#map_customized_options' do
    it 'Should return an array' do
      my_logic = MainLogic.new
      expect(my_logic.map_customized_options(0)).to be_a_kind_of(Array)
    end
    it 'The length of the returned array should be equal to 4' do
      my_logic = MainLogic.new
      expect(my_logic.map_customized_options(0).length).to eq(4)
    end
  end

  describe '#validate_search_keywords' do
    it 'Should convert the given keywords into url encoding' do
      my_logic = MainLogic.new
      expect(my_logic.validate_search_keywords('hp laptop')).to eq('hp+laptop')
    end
  end

  describe '#validate_search_type' do
    it 'Should return the search type if 0 or 1 was given as an argument' do
      my_logic = MainLogic.new
      expect(my_logic.validate_search_type(0)).to eq(0)
    end
  end
end
