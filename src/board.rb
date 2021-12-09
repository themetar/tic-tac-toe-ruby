class Board
  def initialize
    @fields = Array.new(9, :empty)
  end

  def to_s
    @fields
      .each_with_index.map { |mark, i| o = mark == :empty && (i + 1) || mark; " #{o} " }
      .each_slice(3).map { |row| row.join('|') }
      .join("\n-----------\n")
  end
end
