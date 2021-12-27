require_relative './game'
require_relative './utils'

loop do
  puts "\e[H\e[2J" # clear screen
  puts "Welcome to themetar's Tic-Tac-Toe!"
  puts  # blank line
  puts 'Menu:'
  puts '1. Play new game'
  puts '2. Exit'
  puts  # blank line

  choice = Utils.prompt('What would you like to do? Choose from above.') { |input| input == '1' || input == '2' }
  case choice
  when '1'
    # pass 'control' to play method
    Game.new.play
  when '2'
    break # break loop, i.e. end program
  end
end
