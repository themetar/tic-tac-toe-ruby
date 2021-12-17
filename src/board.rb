class Board
  def initialize
    @fields = Array.new(9, :empty)
  end

  def place_mark(location, mark)
    @fields[location - 1] = mark
  end

  def available_cells
    @fields.each_with_index.filter { |mark, _| mark == :empty }
           .map { |_, i| i + 1 }
  end

  def winner
    rows = @fields.each_slice(3)
    columns = (0..2).map { |c| select_by_sequence(@fields, (c..8).step(3)) }
    diagonals = [
      select_by_sequence(@fields, (0..8).step(4)),
      select_by_sequence(@fields, (2..6).step(2))
    ]

    found = (rows + columns + diagonals).each.lazy.map { |line| line_winner(line) }
                               .find { |winner| winner != :empty }

    found || :empty
  end

  def to_s
    @fields
      .each_with_index.map { |mark, i| o = mark == :empty && (i + 1) || mark; " #{o} " }
      .each_slice(3).map { |row| row.join('|') }
      .join("\n-----------\n")
  end

  private

  def select_by_sequence(indexable, sequence)
    sequence.map { |index| indexable[index] }
  end
  
  def line_winner(line)
    return line.first if line.all? { |mark| mark == line.first }
    
    # otherwise return
    :empty
  end
end
