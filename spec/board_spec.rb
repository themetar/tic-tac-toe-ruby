require_relative '../src/board'

describe Board do
  describe '#to_s' do
    it 'returns 3 x 3 grid' do
      expected =
                " 1 | 2 | 3 \n"\
                "-----------\n"\
                " 4 | 5 | 6 \n"\
                "-----------\n"\
                " 7 | 8 | 9 "

      expect(Board.new.to_s).to eq(expected)
    end
  end

  describe '#place_mark' do
    it 'places a mark in a specified cell' do
      brd = Board.new
      
      brd.place_mark(2, 'x')
      expected =
                " 1 | x | 3 \n"\
                "-----------\n"\
                " 4 | 5 | 6 \n"\
                "-----------\n"\
                " 7 | 8 | 9 "
        
      expect(brd.to_s).to eq(expected)

      brd.place_mark(4, 'o')
      expected =
                " 1 | x | 3 \n"\
                "-----------\n"\
                " o | 5 | 6 \n"\
                "-----------\n"\
                " 7 | 8 | 9 "

      expect(brd.to_s).to eq(expected)
    end
  end
end
