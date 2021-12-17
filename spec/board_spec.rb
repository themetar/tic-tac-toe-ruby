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

  describe '#winner' do
    let(:board) { Board.new }

    it 'returns :empty when the game is not completed' do
      board.place_mark(1, 'a')
      board.place_mark(3, 'a')
      board.place_mark(4, 'a')

      expect(board.winner).to eq(:empty)
    end

    context 'when player completes a row' do
      before do
        board.place_mark(1, 'a')
        board.place_mark(2, 'a')
        board.place_mark(4, 'b')
        board.place_mark(5, 'b')
        board.place_mark(7, 'c')
        board.place_mark(8, 'c')
      end

      it 'correctly returns for the first row' do
        board.place_mark(3, 'a')
        expect(board.winner).to eq('a')
      end

      it 'correctly returns for the second row' do
        board.place_mark(6, 'b')
        expect(board.winner).to eq('b')
      end

      it 'correctly returns for the third row' do
        board.place_mark(9, 'c')
        expect(board.winner).to eq('c')
      end
    end

    context 'when player completes a column' do
      before do
        board.place_mark(1, 'a')
        board.place_mark(7, 'a')
        board.place_mark(2, 'b')
        board.place_mark(8, 'b')
        board.place_mark(3, 'c')
        board.place_mark(9, 'c')
      end

      it 'correctly returns for the first column' do
        board.place_mark(4, 'a')
        expect(board.winner).to eq('a')
      end

      it 'correctly returns for the second column' do
        board.place_mark(5, 'b')
        expect(board.winner).to eq('b')
      end

      it 'correctly returns for the third column' do
        board.place_mark(6, 'c')
        expect(board.winner).to eq('c')
      end
    end

    context 'when player completes a diagonal' do
      before do
        board.place_mark(1, 'a')
        board.place_mark(9, 'a')
        board.place_mark(3, 'b')
        board.place_mark(7, 'b')
      end

      it 'correctly returns for the primary diagonal' do
        board.place_mark(5, 'a')
        expect(board.winner).to eq('a')
      end

      it 'correctly returns for the secondary diagonal' do
        board.place_mark(5, 'b')
        expect(board.winner).to eq('b')
      end
    end

    it 'returns :empty when the game is tied (fully filled)' do
      # x o x
      # o o x
      # x x o
      %w(x o x o o x x x o).each_with_index do |mark, index|
        board.place_mark(index + 1, mark)
      end

      expect(board.winner).to eq(:empty)
    end
  end
end
