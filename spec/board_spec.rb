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

  describe '#available_cells' do
    let(:board) { Board.new }

    it 'results to an array of (1..9) for an empty board' do
      expect(board.available_cells).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

    it 'gives free fields for a semi-filled board' do
      board.place_mark(5, 'x')
      board.place_mark(9, 'o')
      board.place_mark(4, 'x')

      expect(board.available_cells).to eq([1, 2, 3, 6, 7, 8])
    end

    it 'results to an empty array for a fully filled board' do
      9.times { |i| board.place_mark(i + 1, 'x') }

      expect(board.available_cells).to eq([])
    end
  end
end
