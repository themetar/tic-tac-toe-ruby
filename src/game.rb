require_relative 'utils'
require_relative 'board'

class Game
  def initialize
    @plays_first = 0
  end

  # Main game loop
  def play
    # ask for player names
    @player_names = [
      Utils.prompt("Enter Player 1's name:") { |name| !name.empty? },
      Utils.prompt("Enter Player 2's name:") { |name| !name.empty? },
    ]

    # external loop for multiple rounds 
    loop do
      game_board = Board.new
      current_player = @plays_first
      player_marks = ['x', 'o']

      # inner loop asks players for their move
      while game_board.available_cells.length > 0
        puts "\e[H\e[2J" # clear screen
        puts game_board
        puts  # blank line
        puts "#{@player_names[current_player]} goes #{game_board.available_cells.length == 9 ? 'first' : 'next'}"
        cell = Utils.prompt('Choose an empty space') { |location| game_board.available_cells.include?(location.to_i) }
        cell = cell.to_i
        game_board.place_mark(cell, player_marks[current_player])
        break if game_board.winner != :empty
        current_player = (current_player + 1) % 2
      end

      puts  # blank line
      
      # evaluate round outcome
      puts "\e[H\e[2J" # clear screen
      puts game_board
      puts # blank line
      if game_board.winner != :empty
        puts "#{@player_names[current_player]} / #{player_marks[current_player]} / wins!"
      else
        puts "It's a tie"
      end

      # offer another round
      choice = Utils.prompt('Would you like to play another round? (yes/no)', 'y') { |ans| ['yes', 'y', 'no', 'n'].include?(ans.downcase) }
      choice = choice.downcase

      break if choice == 'no' || choice == 'n'

      # switch starting player for next round
      @plays_first = (@plays_first + 1) % 2
    end

    # if we get here, the players chose to stop playing and broke from the outer loop.
    # the 'play' method will exit
    puts 'Thank you for playing!'
    sleep(1) # end after 1 second
  end
end
